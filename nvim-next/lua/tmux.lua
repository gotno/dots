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

-- if the need arises to set these maps only when certain criteria are met
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   callback = function()
--     local blocklist = { 'snacks_terminal' }
--     local buffer_type = vim.bo.filetype
--
--     if not vim.tbl_contains(blocklist, buffer_type) then
--       vim.keymap.set(
--         { 'n', 'v' },
--         '<c-h>', '<cmd>TmuxNavigateLeft<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         't',
--         '<c-h>', '<C-\\><C-n><cmd>TmuxNavigateLeft<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         { 'n', 'v' },
--         '<c-j>', '<cmd>TmuxNavigateDown<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         't',
--         '<c-j>', '<C-\\><C-n><cmd>TmuxNavigateDown<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         { 'n', 'v' },
--         '<c-k>', '<cmd>TmuxNavigateUp<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         't',
--         '<c-k>', '<C-\\><C-n><cmd>TmuxNavigateUp<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         { 'n', 'v' },
--         '<c-l>', '<cmd>TmuxNavigateRight<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         't',
--         '<c-l>', '<C-\\><C-n><cmd>TmuxNavigateRight<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         { 'n', 'v' },
--         '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>',
--         { buffer = true }
--       )
--       vim.keymap.set(
--         't',
--         '<c-\\>', '<C-\\><C-n><cmd>TmuxNavigatePrevious<cr>',
--         { buffer = true }
--       )
--     end
--   end,
-- })
