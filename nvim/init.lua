-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'autocmds'
require 'lsp'

require 'color'
require 'git'
require 'markdown'
require 'mini'
require 'robot'
require 'session'
require 'statusline'
require 'tabline'
require 'terminal'
require 'nav'
require 'treesitter'

-- cleanup:
-- :lua =vim.pack.del(vim.iter(vim.pack.get()):filter(function(x) return not x.active end):map(function(x) return x.spec.name end):totable())
