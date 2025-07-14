-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- wrapping
vim.o.wrap = false
-- wrapped line repeats indent
vim.o.breakindent = true

-- case-insensitive search if lowercase unless \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep sign column on
vim.o.signcolumn = 'yes'

-- ms idle timeout before swap is written
vim.o.updatetime = 250
-- ms wait for mapped sequence completion
vim.o.timeoutlen = 300

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
