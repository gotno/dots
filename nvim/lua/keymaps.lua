function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- clear search highlights
map('n', '<leader><Esc>', '<cmd>nohlsearch<CR>')

-- splits
map('n', '<leader>i', ':vsp<CR>')
map('n', '<leader>o', ':sp<CR>')

map('n', ')', '<Nop>')
map('n', '(', '<Nop>')
map('n', ';', ':')

-- buffers
map('n', '<leader>q', ':bd<CR>')
map('n', '<c-n>', ':bn<CR>')
map('n', '<c-p>', ':bp<CR>')
