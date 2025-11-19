return {
  'ahkohd/buffer-sticks.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>s',
      function()
        BufferSticks.jump()
      end,
      desc = 'jump to buffer',
    },
  },
  config = function()
    local sticks = require('buffer-sticks')
    sticks.setup({
      preview = { enabled = false },
    });
    sticks.show()
  end,
}
