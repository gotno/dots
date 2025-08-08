return {
  {
    -- neovim/lua completion, annotations and signatures
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      -- settings = {
      --   tsserver_max_memory = 3072, -- megabytes, 3072 is vscode's default
      -- },
    },
  },
  { 'dmmulroy/ts-error-translator.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
        lazy = false,
        opts = {
          progress = {
            display = {
              done_icon = ' ',
              progress_icon = {
                pattern = {
                  "⠋ ",
                  "⠙ ",
                  "⠹ ",
                  "⠸ ",
                  "⠼ ",
                  "⠴ ",
                  "⠦ ",
                  "⠧ ",
                  "⠇ ",
                  "⠏ ",
                },
              },
            },
          },
          notification = {
            configs = {
              default = {
                name = nil,
                icon = nil,
              },
            },
            view = {
              stack_upwards = false,
            },
            override_vim_notify = true,
            window = {
              border = 'single',
              x_padding = 2,
              y_padding = 2,
              align = 'top',
            },
          },
        },
      },
      'saghen/blink.cmp',
      'folke/snacks.nvim',
      -- {
      --   'nvimdev/lspsaga.nvim',
      --   opts = {
      --     event = 'LspAttach',
      --   },
      -- },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gdo', vim.lsp.buf.code_action, 'goto code actions', { 'n', 'x' })
          map('grn', vim.lsp.buf.rename, 'rename')
          map('grr', require('snacks.picker').lsp_references, 'goto references')
          map('gri', require('snacks.picker').lsp_implementations, 'goto implementation')
          map('grd', require('snacks.picker').lsp_definitions, 'goto definition')
          map('grD', require('snacks.picker').lsp_declarations, 'goto declaration')
          map('grt', require('snacks.picker').lsp_type_definitions, 'goto type definition')
          map('gO', require('snacks.picker').lsp_symbols, 'goto document symbols')
          map('gW', require('snacks.picker').lsp_workspace_symbols, 'goto workspace symbols')
          map('gH', ':LspClangdSwitchSourceHeader<CR>', 'c/c++ switch between source/header')
          map(
            'gll',
            function()
              vim.diagnostic.setloclist()
              vim.opt_local.wrap = true
            end,
            'open diagnostics location list'
          )

          -- highlight/unhighlight hovered word
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight') then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          -- This may be unwanted, since they displace some of your code
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
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
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {
          filetypes = { 'c', 'cpp' },
          root_dir = require('lspconfig').util.root_pattern(
            '.clangd',
            '.git',
            'Makefile'
          ),
        },
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'clangd',
        'eslint_d',
        'prettierd',
        'eslint-lsp',
        'stylelint-lsp',
        'css-lsp',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
