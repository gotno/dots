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
  },
  keys = {
    -- picker
    { '<leader><space>', function() require('snacks.picker').smart() end, desc = 'smart find files' },
    { '<leader>/', function() require('snacks.picker').grep() end, desc = 'live grep files' },

    -- buffers (bufdelete)
    { '<leader>q', function() require('snacks.bufdelete').delete() end, desc = 'close buffer' },
    { '<leader>Q', function() require('snacks.bufdelete').other() end, desc = 'close buffer' },

    { '<leader>z', function() require('snacks.lazygit').open() end, desc = 'close buffer' },
    { 'grs', function() require('snacks.picker').git_status() end, desc = 'close buffer' },
  },
}
