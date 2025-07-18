return {
	'Pocco81/true-zen.nvim',
	config = function()
    require("true-zen").setup({
      modes = {
        narrow = {
          fold_style = 'invisible',
        },
      },
    })
    vim.keymap.set('n', '<leader><enter>', ':TZFocus<CR>')
    vim.keymap.set('n', '<leader>zn', ':TZNarrow<CR>')
    vim.keymap.set('v', '<leader>zn', ":'<,'>TZNarrow<CR>")
	end,
}
