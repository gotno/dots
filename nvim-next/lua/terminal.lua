vim.pack.add({
  'https://github.com/akinsho/toggleterm.nvim',
})

require('toggleterm').setup({
  open_mapping = '<c-t>',
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    local is_terminal = vim.bo.buftype == 'terminal'

    local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    local is_lazygit = string.find(buf_name, 'lazygit')

    if is_terminal and not is_lazygit then
      vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { buffer = true })
    end

    if is_terminal and is_lazygit then
      vim.keymap.set('t', '<esc>', '<nop>', { buffer = true })
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
