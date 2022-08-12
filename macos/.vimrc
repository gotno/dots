let mapleader = "\<Space>"

" vim-plug stuff. this will run one time, if vim-plug isn't already installed.
" add the repository for any plugin you need here.
" if you add others or want to update, reload .vimrc and run `:PlugInstall`
" if you remove any, reload .vimrc and run `:PlugClean`

" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
" vim
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'wesQ3/vim-windowswap' " cut/paste windows with `<leader>ww`
Plug 'kopischke/vim-stay' " keep folds, cursor position etc

" syntax
Plug 'othree/html5.vim'

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'gavocanov/vim-js-indent', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'kchmck/vim-coffee-script'
Plug 'sirtaj/vim-openscad'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-markdown'
Plug 'statianzo/vim-jade'

" linting
Plug 'dense-analysis/ale'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tags and autocomplete
Plug 'ackyshake/VimCompletesMe'

" common
Plug 'tpope/vim-commentary'

call plug#end()

" let g:ycm_server_keep_logfiles = 0
" let g:ycm_server_log_level = 'debug'

" if has('python3')
"   silent! python3 1
" endif

" force the old regex engine to avoid hella slow ruby syntax highlighting
" set re=1

"80th column warning
if exists('+colorcolumn')
  set colorcolumn=81
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
  endif
highlight ColorColumn ctermbg=8

" linter settings
let g:ale_sign_column_always = 1
let g:ale_linters = { 'javascript': ['standard'] }
let g:ale_fixers = {'javascript': ['standard']}
map <leader>L :ALEToggle<cr>
map <leader>F :ALEFix<cr>

" no pipes in the split divider and kill the border
set fillchars+=vert:\
hi VertSplit ctermfg=5 ctermbg=5 term=NONE

set nocompatible
set nowrap
set relativenumber
set number

" indenting
set autoindent
filetype plugin indent on
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType ruby setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" tab completion
" imap <Tab> <C-P>
" imap <S-Tab> <C-X><C-O>

" move swap files out of current directory
set bdir-=.
set bdir+=/tmp
set dir-=.
set dir+=/tmp

" persistent undo
set undodir-=.
set undodir+=/tmp
set undofile

" general
set t_Co=256
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=longest,list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set mouse=nicr

nnoremap j gj
nnoremap k gk
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :


" custom functions
" copy full file path of current buffer
map <leader>yp :let @* = expand("%:p")<CR>
map <leader>cd :let @* = expand("%:p:h")<CR>

" kill all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" enter for G
nnoremap <CR> G

" stupid window what are you for even
map q: :q

" splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow
set splitright

" buffercycle
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" better searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap # *
nnoremap * #

" Y should work like the other capital verbs
nmap Y y$

" bracket matching
nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader><tab> %
runtime macros/matchit.vim

nmap ( <Nop>
nmap ) <Nop>

" jshint2
" let jshint2_read = 1
" let jshint2_save = 1
" let jshint2_confirm = 0
" let jshint2_height = 4

" vim-markdown fenced code highlighting (requires explicitly specified languages)
let g:markdown_fenced_languages = ['json', 'javascript', 'ruby', 'xml']

" airline
set noshowmode

" tagbar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" filetypes
au BufNewFile,BufRead *.js.snap set filetype=javascript
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.sass set filetype=css
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.tag set filetype=html
au BufNewFile,BufRead *.jbuilder set filetype=ruby

" macros
"" convert `whatever`
"" to `puts "whatever #{whatever}"`
"" or `console.log("whatever:", whatever);`
let @p='jIputs "ly$A #{"}"'
let @c='jIconsole.log("ly$A:", ");'

" vim-stay
set viewoptions=cursor,folds,slash,unix

" wrap/unwrap knockout component templates
function! RemoveKOTemplating() range
  silent! execute a:firstline . "," . a:lastline . 's/\s''/ /'
  silent! execute a:firstline . "," . a:lastline .'s/''\s\=+\=$//g'
endfunction
xnoremap <leader>K :call RemoveKOTemplating()<cr>

function! AddKOTemplating() range
  let columncount=len(matchlist(getline(a:firstline), '\(\s*\)')[1])

  " add the beginning `'` at the appropriate column
  silent! execute a:firstline . "," . a:lastline . 's/^\s\{' . columncount . '}/' . repeat(' ', columncount) . '''/'
  " add the ending `' +`
  silent! execute a:firstline . "," . a:lastline . 's/\(.\)$/\1'' +/'
  " remove the ` +` on the last line
  silent! execute a:lastline . "," . a:lastline .  's/\s+$//'
endfunction
xnoremap <leader>k :call AddKOTemplating()<cr>
