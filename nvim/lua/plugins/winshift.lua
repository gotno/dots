local flash = function(cmd)
  local init_bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  local hi = vim.api.nvim_get_hl_by_name("CurSearch", true).background
  vim.api.nvim_set_hl(0, 'normal', { bg = hi })
  vim.cmd(cmd)
  vim.defer_fn(
    function()
      vim.api.nvim_set_hl(0, 'normal', { bg = init_bg })
    end,
    40
  )
end
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
    { '<M-h>', function() flash('WinShift left') end, desc = 'move window left' },
    { '<M-H>', function() flash('WinShift far_left') end, desc = 'move window far left' },
    { '<M-j>', function() flash('WinShift down') end, desc = 'move window down' },
    { '<M-J>', function() flash('WinShift far_down') end, desc = 'move window far down' },
    { '<M-k>', function() flash('WinShift up') end, desc = 'move window up' },
    { '<M-K>', function() flash('WinShift far_up') end, desc = 'move window far up' },
    { '<M-l>', function() flash('WinShift right') end, desc = 'move window right' },
    { '<M-L>', function() flash('WinShift far_right') end, desc = 'move window far right' },
  },
}
