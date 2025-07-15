require('lazy').setup({
  spec = {
    'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically

    -- require 'plugins.colors.darkmatter',
    require 'plugins.colors.rose-pine',

    require 'plugins.blink-cmp',
    require 'plugins.git-signs',
    require 'plugins.lspconfig',
    require 'plugins.mini',
    require 'plugins.snipe',
    require 'plugins.treesitter',
  },
  checker = { enabled = true },
})
