return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  keys = {
    -- picker
    { '<leader><space>', function() require('snacks.picker').smart() end, desc = 'smart find files' },
    { '<leader>/', function() require('snacks.picker').grep() end, desc = 'live grep files' },

    -- buffers (bufdelete)
    { '<leader>q', function() require('snacks.bufdelete').delete() end, desc = 'close buffer' },
    { '<leader>Q', function() require('snacks.bufdelete').other() end, desc = 'close buffer' },

    { '<leader>z', function() require('snacks.lazygit').open() end, desc = 'close buffer' },
  },
}
