vim.pack.add({
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
require('render-markdown').setup({
  -- render_modes = true,
  -- anti_conceal = { enabled = false },
  completions = { lsp = { enabled = true } },
  heading = {
    icons = { '󰬺 ', '󰬻 ', '󰬼 ', '󰬽 ', '󰬾 ', '󰬿 ' },
  },
  sign = { enabled = false },
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  group = vim.api.nvim_create_augroup('gtno-markdown', { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.colorcolumn = ''
  end,
})
