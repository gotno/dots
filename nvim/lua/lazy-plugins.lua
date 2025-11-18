require('lazy').setup({
  spec = {
    'NMAC427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically

    require 'plugins.colors.darkmatter',
    require 'plugins.colors.rose-pine',
    require 'plugins.colors.everforest',
    require 'plugins.colors.forest-night',

    require 'plugins.auto-session',
    require 'plugins.blink-cmp',
    require 'plugins.conform',
    require 'plugins.copilot',
    require 'plugins.deadcolumn',
    require 'plugins.git-signs',
    require 'plugins.incline',
    require 'plugins.lspconfig',
    require 'plugins.markdown',
    require 'plugins.mini',
    require 'plugins.slimline',
    require 'plugins.snacks',
    require 'plugins.snipe',
    require 'plugins.terminal',
    require 'plugins.tmux-nav',
    require 'plugins.treesitter',
    require 'plugins.winshift',
  },
  checker = { enabled = true },
})
