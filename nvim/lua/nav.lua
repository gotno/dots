vim.pack.add({
  'https://github.com/christoomey/vim-tmux-navigator',
})

vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set({ 'n', 'v' }, '<c-h>', '<cmd>TmuxNavigateLeft<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-j>', '<cmd>TmuxNavigateDown<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-k>', '<cmd>TmuxNavigateUp<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-l>', '<cmd>TmuxNavigateRight<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>')

-- see terminal.lua for in-terminal mappings

vim.pack.add({
  -- 'https://github.com/serhez/bento.nvim',
  { src = 'https://github.com/gotno/bento.nvim', version = 'handle-tabpages' },
})
require('bento').setup({
  ui = {
    mode = 'floating', -- "floating" | "tabline"
    floating = {
      -- position = "middle-right", -- See position options below
      -- offset_x = 0, -- Horizontal offset from position
      -- offset_y = 0, -- Vertical offset from position
      -- dash_char = "─", -- Character for collapsed dashes
      -- border = "none", -- "rounded" | "single" | "double" | etc. (see :h winborder)
      -- label_padding = 1, -- Padding around labels
      minimal_menu = 'dashed', -- nil | "dashed" | "filename" | "full"
      -- max_rendered_buffers = nil, -- nil (no limit) or number for pagination
    },
  },
})
