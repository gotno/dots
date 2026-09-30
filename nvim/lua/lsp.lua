vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
});

-- code actions
vim.pack.add({
  'https://github.com/rachartier/tiny-code-action.nvim',
});
require('tiny-code-action').setup({
  picker = {
    'select',
    opts = {
      hotkeys = true,
    },
  },
})

-- inline diagnostics
vim.pack.add({
  'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
});
require('tiny-inline-diagnostic').setup({
  preset = 'powerline',
  options = {
    multilines = {
      enabled = true,
      always_show = true,
      severity = { vim.diagnostic.severity.ERROR },
    },
    show_source = { enabled = true },
    add_messages = {
      show_multiple_glyphs = true,
    },
  },
})

-- robot
vim.lsp.enable('copilot')

-- c, cpp
vim.lsp.enable('clangd')

-- lua
vim.lsp.enable('lua_ls')

-- eslint
vim.lsp.enable('eslint')

-- TODO: how does H do things
--       doesn't follow @imports
-- css
vim.lsp.enable('css-ls')
-- stylint
-- vim.lsp.enable('stylelint')

-- typescript
vim.lsp.enable('tsc')
vim.pack.add({
  -- requires `npm install -g pretty-ts-errors-markdown`
  'https://github.com/youyoumu/pretty-ts-errors.nvim',
});
-- vim.pack.add({
--   'https://github.com/nvim-lua/plenary.nvim',
--   'https://github.com/pmizio/typescript-tools.nvim',
-- });
-- require('typescript-tools').setup({
--   settings = {
--     tsserver_max_memory = 6144, -- 6gb, vscode's 3gb default crashes out
--     separate_diagnostic_server = false,
--   },
--   root_dir = function(bufnr, on_dir)
--     local root_markers = {
--       {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml'},
--       {'.git'},
--     }
--
--     on_dir(vim.fs.root(bufnr, root_markers) or vim.fn.getcwd())
--   end,
-- })

vim.lsp.enable('terraform-ls')
vim.lsp.enable('tofu-ls')

-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('gtno-lsp-attach', { clear = true }),
  callback = function(attach_event)
    vim.keymap.set(
      {'n', 'x'},
      'gdo', require('tiny-code-action').code_action,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )
    vim.keymap.set(
      'n',
      'K',
      function()
        vim.lsp.buf.hover({
          border = 'rounded',
        })
      end,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )
    vim.keymap.set(
      'n',
      'grd', vim.lsp.buf.definition,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )
    vim.keymap.set(
      'n',
      'grr',
      function()
        local MiniPick = require('mini.pick')
        vim.lsp.buf.references(
          nil,
          {
            on_list = function(options)
              -- nearest named package.json per directory, resolved lazily and
              -- cached since most references share a handful of directories.
              -- stops at the repo root so the walk can't escape into $HOME,
              -- and skips manifests without a name (workspace roots, stubs)
              local packages = {}
              local function package_of(dir)
                if packages[dir] == nil then
                  packages[dir] = false
                  local stop = vim.fs.root(dir, '.git')
                  local manifests = vim.fs.find(
                    'package.json',
                    { path = dir, upward = true, type = 'file', limit = math.huge, stop = stop and vim.fs.dirname(stop) }
                  )
                  for _, manifest in ipairs(manifests) do
                    local ok, decoded = pcall(function()
                      return vim.json.decode(table.concat(vim.fn.readfile(manifest), '\n'))
                    end)
                    local name = ok and type(decoded) == 'table' and decoded.name
                    if type(name) == 'string' and name ~= '' then
                      packages[dir] = { name = name, root = vim.fs.dirname(manifest) }
                      break
                    end
                  end
                end
                return packages[dir]
              end
              local function tail(parts)
                if #parts <= 4 then
                  return table.concat(parts, '/')
                end
                return '…/' .. table.concat(vim.list_slice(parts, #parts - 3), '/')
              end
              local items = {}
              for i, item in ipairs(options.items) do
                local filename = vim.fs.normalize(item.filename)
                local pkg = package_of(vim.fs.dirname(filename))
                local relative = pkg and vim.fs.relpath(pkg.root, filename)
                local location
                if relative then
                  location = table.concat({
                    pkg.name,
                    tail(vim.split(relative, '/', { plain = true })),
                  }, ' ')
                else
                  location = tail(vim.split(filename, '/', { plain = true }))
                end
                items[i] = {
                  text = table.concat({
                    table.concat({
                      location,
                      item.lnum,
                      item.col
                    }, ':'),
                    vim.fn.substitute(item.text, '^ *', '', 'g'),
                  }, '  '),
                  path = item.filename,
                  col = item.col,
                  lnum = item.lnum,
                }
              end
              MiniPick.start({
                source = {
                  name = 'lsp references',
                  items = items,
                },
              })
            end,
          }
        )
      end,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )
    -- map('grn', vim.lsp.buf.rename, 'rename')
    -- map('grr', require('snacks.picker').lsp_references, 'goto references')
    -- map('gri', require('snacks.picker').lsp_implementations, 'goto implementation')
    -- map('grD', require('snacks.picker').lsp_declarations, 'goto declaration')
    -- map('grt', require('snacks.picker').lsp_type_definitions, 'goto type definition')
    -- map('gO', require('snacks.picker').lsp_symbols, 'goto document symbols')
    -- map('gW', require('snacks.picker').lsp_workspace_symbols, 'goto workspace symbols')
    vim.keymap.set(
      {'n', 'x'},
      'gH', '<cmd>LspClangdSwitchSourceHeader<cr>',
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )

    -- send diagnostics to loclist
    vim.keymap.set(
      {'n', 'x'},
      'gll',
      function()
        local curwin = vim.api.nvim_get_current_win()
        vim.diagnostic.setloclist()
        local loclist_win = vim.fn.getloclist(curwin, {winid = 0}).winid
        if loclist_win ~= 0 then
          vim.wo[loclist_win].wrap = true
        end
      end,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )

    -- toggle diagnostic float
    vim.keymap.set(
      'n',
      'gdf',
      function()
        local ft = vim.bo[attach_event.buf].filetype

        if ft == 'typescript' or ft == 'typescriptreact' then
          require('pretty-ts-errors').show_formatted_error()
          return
        end

        vim.diagnostic.open_float()
      end,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )

    -- highlight/unhighlight hovered word
    local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
    local supports_highlight = client and
      client:supports_method('textDocument/documentHighlight')
    if client and supports_highlight then
      local highlight_augroup = vim.api.nvim_create_augroup(
        'gtno-lsp-highlight',
        { clear = false }
      )
      vim.api.nvim_create_autocmd(
        {'CursorHold', 'CursorHoldI'},
        {
          buffer = attach_event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        }
      )

      vim.api.nvim_create_autocmd(
        {'CursorMoved', 'CursorMovedI'},
        {
          buffer = attach_event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        }
      )

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup(
          'gtno-lsp-detach',
          { clear = true }
        ),
        callback = function(detach_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = 'gtno-lsp-highlight',
            buffer = detach_event.buf,
          })
        end,
      })
    end
  end,
})

-- diagnostics
-- see :help vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  float = { header = '', border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = false,
})
