return {
  'Bekaboo/deadcolumn.nvim',
  config = function()
    require('deadcolumn').setup({
      scope = 'visible',
      modes = function()
        return true
      end,
    })
  end,
}
