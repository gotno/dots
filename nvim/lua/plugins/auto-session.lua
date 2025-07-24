return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>rr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    { '<leader>rs', '<cmd>SessionSave<CR>', desc = 'Save session' },
    { '<leader>ra', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    git_use_branch_name = true,
    git_auto_restore_on_branch_change = false,
  },
  -- opts = {
  --   session_lens = {
  --     mappings = {
  --       delete_session = { "i", "<C-D>" },
  --       alternate_session = { "i", "<C-S>" },
  --       copy_session = { "i", "<C-Y>" },
  --     },
  --
  --     picker_opts = {
  --       -- For Telescope, you can set theme options here, see:
  --       -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
  --       -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
  --       --
  --       -- border = true,
  --       -- layout_config = {
  --       --   width = 0.8, -- Can set width and height as percent of window
  --       --   height = 0.5,
  --       -- },
  --
  --       -- For Snacks, you can set layout options here, see:
  --       -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
  --       --
  --       -- preset = "dropdown",
  --       -- preview = false,
  --       -- layout = {
  --       --   width = 0.4,
  --       --   height = 0.4,
  --       -- },
  --     },
  --   },
  -- }
}
