" SPDX-License-Identifier: MIT
"
" Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>
"

"==============================================================================
" PLUGINS
"==============================================================================
"{{{

" Grab latest vim-plug from github
let s:vim_root = expand('<sfile>:p:h')
if empty(glob(s:vim_root . '/autoload/plug.vim'))
  silent call system('mkdir -p ' . s:vim_root . '/autoload')
  silent call system('curl -fLo ' . s:vim_root . '/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source' s:vim_root . '/autoload/plug.vim'
endif

call plug#begin(s:vim_root . '/plugged')

Plug 'tpope/vim-fugitive'                               " Awesome git wrapper
Plug 'dense-analysis/ale'                               " Powerful linting tool
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Language server
Plug 'godlygeek/tabular'                                " Text alignment
Plug 'vim-airline/vim-airline'                          " Sexy statusline
Plug 'joshdick/onedark.vim'                             " Onedark colorscheme
Plug 'tpope/vim-commentary'                             " Commentary stuff
Plug 'mhinz/vim-startify'                               " Cool start menu
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown preview
Plug 'bfrg/vim-cpp-modern'                              " Better syntax highlighting for C/C++
Plug 'ap/vim-css-color'                                 " CSS color preview
Plug 'psliwka/vim-smoothie'                             " Smoothie
Plug 'airblade/vim-gitgutter'                           " Shows modified lines in number column

if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim'          " Indent level
endif

call plug#end()

"== All one-liners plugin settings go below =="

" char list for different indentation level
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Ignore indent lines on these filetypes
let g:indent_blankline_filetype_exclude = ['help', 'markdown', 'startify']

" Use github dark background
let g:onedark_color_overrides = {
        \ "background": {"gui": "#0D1117", "cterm": "234", "cterm16": "0" },
        \}

" Change colorscheme to onedark if installed
" NOTE: Make sure to set colorscheme before setting any custom highlighting options
if !empty(glob(s:vim_root . '/plugged/onedark.vim'))
    colorscheme onedark
endif

"}}}

"==============================================================================
" GENERAL SETTINGS
"==============================================================================
"{{{
filetype plugin indent on   " Used for indentation based on file-type
syntax enable               " Enable syntax highlighting
set encoding=utf-8          " It's the default in nvim but vim sets it conditionally
set nowrap                  " Do not wrap code by default
set expandtab               " Expand TABs to spaces
set shiftwidth=4            " Indents will have a width of 4
set tabstop=4               " The width of a TAB is set to 4.
                            " Still it is a \t. It is just that
                            " vim will interpret it to be having
                            " a width of 4.
set softtabstop=4           " Sets the number of columns for a TAB
set shell=bash              " Set default shell to bash coz zsh isn't POSIX-compatible
set incsearch               " Incrementally highlights search patterns
set nobackup                " Disable backup
set nowritebackup
set termguicolors           " Term supports gui colors
set number                  " Show line numbers
set cursorline              " Highlight current line number
set mouse=ni                " Enable mouse support in normal and insert mode
set hidden                  " Allow buffers to be hidden
set cmdheight=2             " Set command panel height
set colorcolumn=80          " Highlight 80th column
set signcolumn=auto         " Show signcolumn seperately when there's a sign
set lazyredraw              " Don't redrawn while executing macros
set title                   " Set window title appropriately
set fillchars+=vert:│,eob:. " Set vertical and empty lines chars
set synmaxcol=190           " Don't even try to highlight stuff that's longer than 190 columns
let mapleader = ","         " Set global <Leader> to `,`

" Source all additional config files
for additional_files in split(glob(s:vim_root . '/configs/*.vim'), '\n')
    execute 'source' additional_files
endfor

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=darkred guibg=#FF0000
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" Highlight tabs in yellow
let g:tab_highlight = 1
highlight Tabs ctermbg=yellow guibg=#FFFF00
call matchadd('Tabs', '\t')
autocmd BufWinEnter * call matchadd('Tabs', '\t')
autocmd BufWinLeave * call clearmatches()
"}}}

"==============================================================================
" [AUTO]COMMANDS
"==============================================================================
"{{{

" Only highlight colorcolumn and cursorline on active window
autocmd WinLeave * set nocursorline colorcolumn=
autocmd WinEnter * set cursorline colorcolumn=80

" Need no line numbers in terminal
if has('nvim')
    autocmd TermOpen * setlocal nonumber
endif

" Define custom Help command that opens help in a floating window
" (https://gist.github.com/wbthomason/5e249439b5fc5738cb4b44419e302f68)
command! -complete=help -nargs=? Help call FloatingWindow('setlocal filetype=help buftype=help | help ', <q-args>)

"}}}
