require('lazy').setup({
  spec = {
    'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically

    require 'plugins.colors.rose-pine',

    require 'plugins.treesitter',
    require 'plugins.mini',
  },
  checker = { enabled = true },
})
