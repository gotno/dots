vim.pack.add({
  'https://github.com/zaldih/themery.nvim',

  -- schemes
  'https://github.com/stevedylandev/darkmatter-nvim',
  'https://github.com/sainnhe/everforest',
  'https://github.com/rose-pine/neovim',
  'https://github.com/vertexE/synth.nvim',
})

require('rose-pine').setup({
  dim_inactive_windows = false,
  extend_background_behind_borders = true,
})

require('themery').setup({
  livePreview = true,
  themes = {
    {
      name = 'darkmatter',
      colorscheme = 'darkmatter',
      before = [[
        vim.opt.background = 'dark'
      ]],
    },
    {
      name = 'everforest dark+soft',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'dark'
        vim.g.everforest_background = 'soft'
      ]],
    },
    {
      name = 'everforest dark+medium',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'dark'
        vim.g.everforest_background = 'medium'
      ]],
    },
    {
      name = 'everforest dark+hard',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'dark'
        vim.g.everforest_background = 'hard'
      ]],
    },
    {
      name = 'everforest light+soft',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'light'
        vim.g.everforest_background = 'soft'
      ]],
    },
    {
      name = 'everforest light+medium',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'light'
        vim.g.everforest_background = 'medium'
      ]],
    },
    {
      name = 'everforest light+hard',
      colorscheme = 'everforest',
      before = [[
        vim.opt.background = 'light'
        vim.g.everforest_background = 'hard'
      ]],
    },
    {
      name = 'rose-pine',
      colorscheme = 'rose-pine',
      before = [[
        vim.opt.background = 'dark'
        require('rose-pine').colorscheme('main')
      ]],
    },
    {
      name = 'rose-pine moon',
      colorscheme = 'rose-pine',
      before = [[
        vim.opt.background = 'dark'
        require('rose-pine').colorscheme('moon')
      ]],
    },
    {
      name = 'rose-pine dawn',
      colorscheme = 'rose-pine',
      before = [[
        vim.opt.background = 'light'
        require('rose-pine').colorscheme('dawn')
      ]],
    },
    -- {
    --   name = 'synth light',
    --   colorscheme = 'synth',
    --   before = [[
    --     vim.opt.background = 'light'
    --   ]],
    -- },
    -- {
    --   name = 'synth',
    --   colorscheme = 'synth',
    --   before = [[
    --     vim.opt.background = 'dark'
    --   ]],
    -- },
  }
})
