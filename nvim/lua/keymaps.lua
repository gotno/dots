function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- linewise nav works the same for wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- clear search highlights
map('n', '<leader><Esc>', ':nohlsearch<CR>')

-- splits
map('n', '<leader>i', ':vsp<CR>')
map('n', '<leader>o', ':sp<CR>')

map('n', ')', '<Nop>')
map('n', '(', '<Nop>')
map('n', ';', ':')

-- buffers
-- (delete handled by snacks)
-- next/prev
map('n', '<c-n>', ':bn<CR>')
map('n', '<c-p>', ':bp<CR>')
-- maximize buffer (split to new tab)
map('n', '<leader><enter>', ':tab split<cr>', { desc = 'maximize window' })

-- toggle 'narrow selection' (fold all but visual line selection, unfold all)
map('v', '<leader>zn', '<esc>`<kzfgg`>jzfG`<', { desc = 'fold all but selection' })
map('n', '<leader>zn', 'zR', { desc = 'open all folds' })

-- panes
map('n', '<leader>w', ':q<CR>')
map('n', '<leader>W', ':qa<CR>')
map('n', '=', '<cmd>vertical resize +5<cr>')
map('n', '-', '<cmd>vertical resize -5<cr>')
map('n', '+', '<cmd>horizontal resize +2<cr>')
map('n', '_', '<cmd>horizontal resize -2<cr>')

-- refresh
map('n', '<leader>r', ':e<CR>')
