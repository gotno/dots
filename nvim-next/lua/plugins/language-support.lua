return {
  -- install: lua-language-server
  {
    'folke/lazydev.nvim',
    opts = {},
    ft = 'lua',
  },

  -- install: typescript-language-server
  {
    'Yuki-bun/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      settings = {
        tsserver_max_memory = 8192, -- megabytes, vscode default is 3072
      },
    },
  },

  -- -- lspconfig
  -- {
  --   'neovim/nvim-lspconfig',
  --   config = function()
  --   end,
  -- },

  -- completion
  {
    'saghen/blink.cmp',
    -- build = 'cargo build --release',
    -- build = 'nix run .#build-plugin',
    version = '1.*',
    opts = {
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },
    },
    -- opts = {
    --   sources = {
    --     default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    --     providers = {
    --       lazydev = {
    --         name = 'LazyDev',
    --         module = 'lazydev.integrations.blink',
    --         score_offset = 100,
    --       },
    --     },
    --   },
    -- },
  }
}
