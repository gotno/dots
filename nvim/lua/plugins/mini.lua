return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    require('mini.icons').setup()
    require('mini.files').setup({
      mappings = {
        close = '<C-c>',
        synchronize = 'R', -- "resolve"
        go_in_plus = 'E',
      },
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
      },
    })
  end,
  keys = {
    {
      '<leader>e',
      function ()
        local MiniFiles = require("mini.files")
        local _ = MiniFiles.close()
          or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        vim.defer_fn(function()
          MiniFiles.reveal_cwd()
        end, 30)
      end,
      desc = "toggle mini.files",
    }
  },
}
