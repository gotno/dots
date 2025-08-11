return {
  'sindrets/winshift.nvim',
  config = function()
    require('winshift').setup({
      highlight_moving_win = true,
      keymaps = {
        disable_defaults = true,
      },
    })
  end,
  keys = {
    { '<M-h>', '<cmd>WinShift left<cr>', desc = 'move window left' },
    { '<M-H>', '<cmd>WinShift far_left<cr>', desc = 'move window far left' },
    { '<M-j>', '<cmd>WinShift down<cr>', desc = 'move window down' },
    { '<M-J>', '<cmd>WinShift far_down<cr>', desc = 'move window far down' },
    { '<M-k>', '<cmd>WinShift up<cr>', desc = 'move window up' },
    { '<M-K>', '<cmd>WinShift far_up<cr>', desc = 'move window far up' },
    { '<M-l>', '<cmd>WinShift right<cr>', desc = 'move window right' },
    { '<M-L>', '<cmd>WinShift far_right<cr>', desc = 'move window far right' },
  },
}
