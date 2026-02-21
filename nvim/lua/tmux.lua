vim.pack.add({
  'https://github.com/christoomey/vim-tmux-navigator',
})

vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set({ 'n', 'v' }, '<c-h>', '<cmd>TmuxNavigateLeft<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-j>', '<cmd>TmuxNavigateDown<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-k>', '<cmd>TmuxNavigateUp<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-l>', '<cmd>TmuxNavigateRight<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>')

-- in a terminal, exit insert mode first
vim.keymap.set('t', '<c-h>', '<c-\\><c-n><cmd>TmuxNavigateLeft<cr>')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><cmd>TmuxNavigateDown<cr>')
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><cmd>TmuxNavigateUp<cr>')
vim.keymap.set('t', '<c-l>', '<c-\\><c-n><cmd>TmuxNavigateRight<cr>')
vim.keymap.set('t', '<c-\\>', '<c-\\><c-n><cmd>TmuxNavigatePrevious<cr>')
