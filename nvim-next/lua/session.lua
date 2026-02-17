vim.pack.add({
  'https://github.com/rmagatti/auto-session',
})
require('auto-session').setup({
  git_use_branch_name = true,
  git_auto_restore_on_branch_change = false,
  -- session_lens = {
  --   mappings = {
  --     delete_session = { 'i', '<c-d>' },
  --     alternate_session = { 'i', '<c-s>' },
  --     copy_session = { 'i', '<c-y>' },
  --   },
  -- },
})

vim.keymap.set(
  {'n', 'x'},
  '<leader>rr', '<cmd>AutoSession search<cr>',
  { noremap = false, silent = false }
)
vim.keymap.set(
  {'n', 'x'},
  '<leader>rs', '<cmd>AutoSession save<cr>',
  { noremap = false, silent = false }
)
vim.keymap.set(
  {'n', 'x'},
  '<leader>rt', '<cmd>AutoSession toggle<cr>',
  { noremap = false, silent = false }
)
