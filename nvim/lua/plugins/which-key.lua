return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    ---@type false | 'classic' | 'modern' | 'helix'
    preset = 'classic',
    triggers = {},
    plugins = {
      marks = false,
      registers = false,
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
