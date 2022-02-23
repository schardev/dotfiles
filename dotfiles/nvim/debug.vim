" THIS FILE IS ONLY FOR DEBUGGING MY VIM ENVIRONMENT!!
let s:vim_root = expand('<sfile>:p:h')
if empty(glob(s:vim_root . '/autoload/plug.vim'))
    silent call system('curl -fLo ' . s:vim_root . '/autoload/plug.vim --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(s:vim_root . '/plugged')
    Plug 'mhinz/vim-startify'
call plug#end()

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
