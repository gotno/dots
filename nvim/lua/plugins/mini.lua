return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.icons').setup()
      require('mini.files').setup({
        mappings = {
          close = '<Esc>',
          synchronize = 'R', -- "resolve"
        },
        windows = {
          preview = false,
        },
      })
    end,
    keys = {
      {"<leader>e", function () require("mini.files").open() end, desc = "Open mini.files"}
    },
  },
}
