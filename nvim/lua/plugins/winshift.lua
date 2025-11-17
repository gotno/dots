local flash = function(cmd)
  local init_bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  local hi = vim.api.nvim_get_hl_by_name("Visual", true).background
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
        -- disable_defaults = true,
      },
    })
  end,
  keys = {
    { '<leader><C-h>', function() flash('WinShift left') end, desc = 'move window left' },
    { '<leader><C-j>', function() flash('WinShift down') end, desc = 'move window down' },
    { '<leader><C-k>', function() flash('WinShift up') end, desc = 'move window up' },
    { '<leader><C-l>', function() flash('WinShift right') end, desc = 'move window right' },
    -- { '<C-M-H>', function() flash('WinShift far_left') end, desc = 'move window far left' },
    -- { '<C-M-J>', function() flash('WinShift far_down') end, desc = 'move window far down' },
    -- { '<C-M-K>', function() flash('WinShift far_up') end, desc = 'move window far up' },
    -- { '<C-M-L>', function() flash('WinShift far_right') end, desc = 'move window far right' },
  },
}
