-- try `npm install -g tree-sitter-cli`
-- or `cargo install tree-sitter-cli`

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
require('nvim-treesitter').install({
  'diff',
  'bash',
  'zsh',
  'c',
  'cpp',
  'html',
  'css',
  'jsdoc',
  'javascript',
  'typescript',
  'json',
  'tsx',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
})

-- `:echo getcompletion('', 'filetype')`
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'css',
    'scss',
    'diff',
    'lua',
    'vim',
    'viminfo',
    'xhtml',
    'json',
  },
  callback = function()
    vim.treesitter.start()

    -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo[0][0].foldmethod = 'expr'

    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
