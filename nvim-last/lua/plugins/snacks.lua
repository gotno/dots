return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    picker = {
      formatters = {
        file = {
          filename_first = false, -- display filename before the file path
          truncate = 100, -- truncate the file path to (roughly) this length
        },
      },
    },
    -- terminal = {
    --   keys = {
    --   },
    -- },
  },
  keys = {
    -- picker
    { '<leader><space>', function() require('snacks.picker').smart() end, desc = 'smart find files' },
    { '<leader>/', function() require('snacks.picker').grep() end, desc = 'live grep files' },

    -- buffers (bufdelete)
    { '<leader>q', function() require('snacks.bufdelete').delete() end, desc = 'close buffer' },
    { '<leader>Q', function() require('snacks.bufdelete').other() end, desc = 'close buffer' },

    -- lazygit and associated pickers
    { '<leader>zz', function() require('snacks.lazygit').open() end, desc = 'close buffer' },
    { '<leader>zl', function() require('snacks.lazygit').log() end, desc = 'close buffer' },
    { '<leader>zf', function() require('snacks.lazygit').log_file() end, desc = 'close buffer' },
    { '<leader>zs', function() require('snacks.picker').git_status() end, desc = 'close buffer' },
  },
}
