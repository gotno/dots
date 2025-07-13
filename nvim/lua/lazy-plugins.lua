require('lazy').setup({
  spec = {
    require 'plugins.colors.rose-pine', 
    'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically
  },
  checker = { enabled = true },
})
