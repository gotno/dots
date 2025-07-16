require('lazy').setup({
  spec = {
    'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically

    -- require 'plugins.colors.darkmatter',
    require 'plugins.colors.rose-pine',
    -- require 'plugins.colors.everforest',

    require 'plugins.blink-cmp',
    require 'plugins.git-signs',
    require 'plugins.lspconfig',
    require 'plugins.mini',
    require 'plugins.snacks',
    require 'plugins.snipe',
    require 'plugins.tmux-nav',
    require 'plugins.treesitter',
  },
  checker = { enabled = true },
})
