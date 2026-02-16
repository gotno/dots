vim.pack.add({
  'https://github.com/akinsho/toggleterm.nvim',
})

require('toggleterm').setup({
  open_mapping = '<c-t>',
})

vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
