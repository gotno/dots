-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- wrapping
vim.o.wrap = false
-- wrapped line repeats indent
vim.o.breakindent = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

-- highlighted rows & columns
vim.o.cursorline = true
vim.o.colorcolumn = '81'

-- min lines above & below cursor
vim.o.scrolloff = 4

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

-- persistent undo
vim.o.undofile = true

-- show one status line for all buffers
vim.o.laststatus = 3
-- mode is in slimline
vim.o.showmode = false

-- case-insensitive search if lowercase unless \C
vim.o.ignorecase = true
vim.o.smartcase = true

-- ms idle timeout before swap is written
vim.o.updatetime = 250
-- ms wait for mapped sequence completion
vim.o.timeoutlen = 1000

-- confirm unsaved with option to save
vim.o.confirm = true

vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- markdown wants 4 space tabs and that is gross
vim.g.markdown_recommended_style = 0
