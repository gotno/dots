vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
});

local potential_clients = { 'lua_ls', 'clangd', 'typescript-tools' }

-- code actions
vim.pack.add({
  'https://github.com/rachartier/tiny-code-action.nvim',
});
require("tiny-code-action").setup({
  picker = {
    'buffer',
    opts = {
      hotkeys = true,
    },
  },
})

-- c, cpp
vim.lsp.enable('clangd')

-- lua
vim.lsp.enable('lua_ls')

-- eslint
vim.lsp.enable('eslint')

-- TODO: how do we do things
--       doesn't follow @imports
-- css
vim.lsp.enable('css-ls')
-- stylint
-- vim.lsp.enable('stylelint')

-- typescript
-- vim.lsp.enable('tsgo')
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pmizio/typescript-tools.nvim',
});
require('typescript-tools').setup({
	root_dir = function(bufnr, on_dir)
		local root_markers = {
	    {'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml'},
			{'.git'},
		}

		on_dir(vim.fs.root(bufnr, root_markers) or vim.fn.getcwd())
	end,
})

-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('gtno-lsp-attach', { clear = true }),
  callback = function(attach_event)
    -- restart active lsps
    vim.keymap.set(
      'n',
      '<leader>R',
      function()
        for _, client in ipairs(potential_clients) do
          if vim.lsp.is_enabled(client) then
            vim.lsp.enable(client, false)
            vim.lsp.enable(client, true)
          end
        end
      end
    )

    vim.keymap.set(
      {'n', 'x'},
      'gdo', require("tiny-code-action").code_action,
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
              local items = {}
              for i, item in ipairs(options.items) do
                items[i] = {
                  text = table.concat({
                    table.concat({
                      vim.fs.basename(item.filename),
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
        vim.diagnostic.setloclist()
        vim.opt_local.wrap = true
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
        vim.diagnostic.open_float()
      end,
      {
        buffer = attach_event.buf,
        noremap = true,
        silent = true,
      }
    )

    -- toggle inlay hint
    vim.keymap.set(
      'n',
      '<leader>th',
      function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = attach_event.buf })
        )
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
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

