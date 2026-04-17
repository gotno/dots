vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
require('render-markdown').setup({
  -- render_modes = true,
  -- anti_conceal = { enabled = false },
  completions = { lsp = { enabled = true } },
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  group = vim.api.nvim_create_augroup('gtno-markdown', { clear = true }),
  callback = function()
    vim.o.wrap = true
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.cursorline = false
    vim.o.colorcolumn = ''
  end,
})
