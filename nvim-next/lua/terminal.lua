vim.pack.add({
  'https://github.com/akinsho/toggleterm.nvim',
})

require('toggleterm').setup({
  open_mapping = '<c-t>',
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  callback = function()
    local is_lazygit =
      string.find(vim.api.nvim_buf_get_name(0), 'lazygit') ~= nil

    if not is_lazygit then
      vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { buffer = true })
    end
  end,
})

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = 'lazygit',
  hidden = true,
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'rounded',
  },
})

vim.keymap.set(
  {'n', 't'},
  ',,', function() lazygit:toggle() end,
  { noremap = true, silent = true }
)
