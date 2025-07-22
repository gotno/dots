-- some themes need this?
vim.opt.termguicolors = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.colorcolumn = '80'

vim.o.laststatus = 3

vim.o.undofile = true

-- wrapping
vim.o.wrap = false
-- wrapped line repeats indent
vim.o.breakindent = true

vim.o.showmode = false

-- case-insensitive search if lowercase unless \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep sign column on
vim.o.signcolumn = 'yes'

-- ms idle timeout before swap is written
vim.o.updatetime = 250
-- ms wait for mapped sequence completion
vim.o.timeoutlen = 1000

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

-- highlight the current line
vim.o.cursorline = true

-- line count buffer when scrolling
vim.o.scrolloff = 4

-- confirm unsaved with option to save
vim.o.confirm = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- briefly highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
