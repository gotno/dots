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
Plug 'bfrg/vim-cpp-modern'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'suy/vim-context-commentstring'

Plug 'sirtaj/vim-openscad'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-markdown'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tags and autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-json', 'coc-eslint', 'coc-prettier' ]
" for js, :CocInstall coc-tsserver and coc-json and coc-eslint
" for ruby, https://github.com/neoclide/coc-solargraph
" for cpp, https://codevion.github.io/#!vim/coc.md

" common
Plug 'tpope/vim-commentary'

" enable OSC52 yankin' (for copying to the clipboard from ssh)
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" copilot
Plug 'github/copilot.vim'


call plug#end()

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let mapleader = "\<Space>"

set updatetime=300

"80th column warning
if exists('+colorcolumn')
  set colorcolumn=81
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
  endif
highlight ColorColumn ctermbg=8

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType cpp setlocal commentstring=//\ %s

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
" copilot
map <leader>cp :Copilot panel<CR>

" buffers
map [b :bp<CR>
map ]b :bn<CR>

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
runtime macros/matchit.vim

nmap ( <Nop>
nmap ) <Nop>

" jshint2
" let jshint2_read = 1
" let jshint2_save = 1
" let jshint2_confirm = 0
" let jshint2_height = 4

" vim-markdown fenced code highlighting (requires explicitly specified languages)
let g:markdown_fenced_languages = ['json', 'javascript', 'typescript', 'ruby', 'xml']

" airline
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 1

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
let @c="jIconsole.log('ly$A:', \");"

" vim-stay
set viewoptions=cursor,folds,slash,unix

""" coc settings
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" open actions menu, useful for fixing eslint/prettier complaints
nmap <leader>do <Plug>(coc-codeaction)

" format with prettier
vmap <leader>f  <Plug>(coc-format-selected)

" sort inline
vmap <leader>s :sort i<CR>

" better colors for the Pmenu (for Coc completion etc)
hi Pmenu ctermbg=0 ctermfg=15
hi PmenuSel ctermbg=15 ctermfg=0

" oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual

" cursors
let &t_SI = WrapForTmux("\e[5 q") " insert mode
let &t_SR = WrapForTmux("\e[4 q") " replace mode
let &t_EI = WrapForTmux("\e[2 q") " normal mode

" auto paste/nopaste
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

let g:copilot_workspace_folders = ["~/dev/hello-world"]

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
