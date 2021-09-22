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

" Awesome git wrapper
Plug 'tpope/vim-fugitive'

" Powerful linting tool
Plug 'dense-analysis/ale'

" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Text alignment
Plug 'godlygeek/tabular'

" Sexy statusline
Plug 'vim-airline/vim-airline'

" Onedark colorscheme
Plug 'joshdick/onedark.vim'

" Indent level
Plug 'lukas-reineke/indent-blankline.nvim'

" Commentary stuff
Plug 'tpope/vim-commentary'

" Cool start menu
Plug 'mhinz/vim-startify'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Better syntax highlighting for C/C++
Plug 'bfrg/vim-cpp-modern'

" CSS color preview
Plug 'ap/vim-css-color'

" Smoothie
Plug 'psliwka/vim-smoothie'

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

" Only highlight colorcolumn and cursorline on active window
autocmd WinLeave * set nocursorline colorcolumn=
autocmd WinEnter * set cursorline colorcolumn=80

" Define custom Help command that opens help in a floating window
" (https://gist.github.com/wbthomason/5e249439b5fc5738cb4b44419e302f68)
command! -complete=help -nargs=? Help call FloatingWindow('setlocal filetype=help buftype=help | help ', <q-args>)
"}}}
