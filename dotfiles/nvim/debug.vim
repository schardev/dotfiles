" THIS FILE IS ONLY FOR DEBUGGING MY VIM ENVIRONMENT!!

let s:vim_root = expand('<sfile>:p:h')
if empty(glob(s:vim_root . '/autoload/plug.vim'))
  silent call system('mkdir -p ' . s:vim_root . '/autoload')
  silent call system('curl -fLo ' . s:vim_root . '/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source' s:vim_root . '/autoload/plug.vim'
endif

call plug#begin(s:vim_root . '/plugged')

Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'

call plug#end()

let g:onedark_color_overrides = {
        \ "background": {"gui": "#0D1117", "cterm": "234", "cterm16": "0" },
        \}

if !empty(glob(s:vim_root . '/plugged/onedark.vim'))
    colorscheme onedark
endif

filetype plugin indent on
syntax enable
set nowrap expandtab shiftwidth=4 tabstop=4 softtabstop=4
set nobackup nowritebackup
set shell=bash
set incsearch
set termguicolors
set number
set cursorline
set mouse=ni
set hidden
set cmdheight=2
set colorcolumn=80
set signcolumn=auto
let mapleader = ","

nnoremap <silent> <C-Up> :wincmd k<CR>
nnoremap <silent> <C-Down> :wincmd j<CR>
nnoremap <silent> <C-Left> :wincmd h<CR>
nnoremap <silent> <C-Right> :wincmd l<CR>

nnoremap <silent> <C-S-Up> :wincmd K<CR>
nnoremap <silent> <C-S-Down> :wincmd J<CR>
nnoremap <silent> <C-S-Left> :wincmd H<CR>
nnoremap <silent> <C-S-Right> :wincmd L<CR>

nnoremap <silent> <Leader>n :bnext<CR>
nnoremap <silent> <Leader>N :bprevious<CR>
nnoremap <silent> <C-d> :bdelete<CR>
autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 && empty(bufname()) | Startify | endif
"
