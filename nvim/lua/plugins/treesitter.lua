return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- <- use for opts
    opts = {
      ensure_installed = {
        'diff',
        'bash',

        'c',
        'cpp',

        'html',
        'css',

        'jsdoc',
        'javascript',
        'typescript',
        'json',

        'lua',
        'luadoc',

        'markdown',
        'markdown_inline',

        'query',

        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- use regex syntax and treesitter together
        -- ruby needs it for indenting
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' }
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "gnn",
      --     node_incremental = "grn",
      --     scope_incremental = "grc",
      --     node_decremental = "grm",
      --   },
      -- },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context', opts = {}
  },
}
