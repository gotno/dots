function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- map('n', '<leader>Z', ':Lazy<cr>', { desc = 'LazyVim' })
-- map('n', '<leader>M', ':Mason<cr>', { desc = 'Mason' })

-- linewise nav works the same for wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- beginning/end of line on H/L
map('n', 'H', '^')
map('n', 'dH', 'd^')
map('n', 'cH', 'c^')
map('n', 'yH', 'y^')
map('n', 'L', '$')
-- (for completeness, but same as D/C/Y)
map('n', 'dL', 'd$')
map('n', 'cL', 'c$')
map('n', 'yL', 'y$')

-- clear search highlights
map('n', '<leader><Esc>', ':nohlsearch<CR>')

-- terminal
-- map esc back to exit insert mode
map('t', '<Esc>', "<C-\\><C-n>")

-- splits
map('n', '<leader>i', ':vsp<CR>')
map('n', '<leader>o', ':sp<CR>')

map('n', ')', '<Nop>')
map('n', '(', '<Nop>')
map('n', ';', ':')

-- buffers
-- - next/prev (delete handled by snacks)
map('n', '<c-n>', ':bn<CR>')
map('n', '<c-p>', ':bp<CR>')
-- - toggle maximize (split to new tab)
map(
  'n',
  '<leader><enter>',
  function ()
    local bufnums = vim.fn.tabpagebuflist()
    local num_relevant_bufs = 0
    for _, v in ipairs(bufnums) do
      if vim.bo[v].buftype == '' or vim.bo[v].buftype == 'help' then
        num_relevant_bufs = num_relevant_bufs + 1
      end
      if num_relevant_bufs > 1 then
        vim.cmd('tab split')
        return
      end
    end

    vim.cmd.quit()
  end,
  { desc = 'maximize window' }
)
map('n', '<leader>T', ':tabe<cr>')

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
