" SPDX-License-Identifier: MIT
"
" Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>
"

"==============================================================================
" PLUGINS
"==============================================================================
"{{{

" Grab latest vim-plug from github
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent call system('mkdir -p $HOME/.config/nvim/autoload')
  silent call system('curl -fLo $HOME/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  $HOME/.config/nvim/autoload/plug.vim'
endif

call plug#begin('$HOME/.config/nvim/plugged')

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

call plug#end()

" All one-liners plugin settings go below
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
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


let mapleader = ","         " Set global <Leader> to `,`

" Source all additional config files
for additional_files in split(glob('$HOME/.config/nvim/configs/*.vim'), '\n')
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
