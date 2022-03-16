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
    silent call system('curl -fLo ' . s:vim_root . '/autoload/plug.vim --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(s:vim_root . '/plugged')

Plug 'dense-analysis/ale'                               " Powerful linting tool
Plug 'dstein64/vim-startuptime'                         " Shows human friendly startuptime
Plug 'godlygeek/tabular', {'for': 'markdown'}           " Text alignment
Plug 'iamcco/markdown-preview.nvim',
    \ { 'do': 'cd app && yarn install' }                " Markdown preview
Plug 'mattn/emmet-vim',
    \ {'for': ['html', 'css', 'scss']}                  " Emmet
Plug 'mhinz/vim-startify'                               " Cool start menu
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Language server
Plug 'tpope/vim-commentary'                             " Commentary stuff
Plug 'tpope/vim-fugitive'                               " Awesome git wrapper
Plug 'tpope/vim-surround'                               " Surrounding stuff

if has('nvim')
    Plug 'akinsho/bufferline.nvim'                      " Sax bufferline
    Plug 'kyazdani42/nvim-tree.lua'                     " Lua fork of Nerdtree
    Plug 'kyazdani42/nvim-web-devicons'                 " File icons
    Plug 'lukas-reineke/indent-blankline.nvim'          " Indent level
    Plug 'navarasu/onedark.nvim'                        " Lua fork of onedark colorscheme
    Plug 'nvim-lualine/lualine.nvim'                    " Statusline plugin
    Plug 'nvim-treesitter/nvim-treesitter',
        \ {'do': ':TSUpdate'}                           " Better syntax highlighting
    Plug 'nvim-treesitter/playground'                   " treesitter querying
    Plug 'p00f/nvim-ts-rainbow'                         " Rainbow brackets
else
    Plug 'joshdick/onedark.vim'                         " Onedark colorscheme for vim
    Plug 'vim-airline/vim-airline'                      " Statusline plugin for vim
endif

call plug#end()

" Disable neovim providers
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0

"}}}

"==============================================================================
" GENERAL SETTINGS
"==============================================================================
"{{{

filetype plugin indent on   " Used for indentation based on file-type
syntax enable               " Enable syntax highlighting
let mapleader = ","         " Set global <Leader> to `,`
set cmdheight=2             " Set command panel height
set colorcolumn=80          " Highlight 80th column
set cursorline              " Highlight current line number
set encoding=utf-8          " It's the default in nvim but vim sets it conditionally
set expandtab               " Expand TABs to spaces
set fillchars+=vert:│,eob:~ " Set vertical and empty lines chars
set hidden                  " Allow buffers to be hidden
set ignorecase              " Ignore case for pattern matching by default
set incsearch               " Incrementally highlights search patterns
set lazyredraw              " Don't redrawn while executing macros
set mouse=ni                " Enable mouse support in normal and insert mode
set nobackup                " Disable backup
set nowrap                  " Do not wrap code by default
set nowritebackup
set number                  " Show line numbers
set numberwidth=2           " Minimal number of columns to use for the line number
set relativenumber          " Shows line number relative to the current line
set scrolloff=3             " Scroll offset
set shell=bash              " Set default shell to bash coz zsh isn't POSIX-compatible
set shiftwidth=4            " Indents will have a width of 4
set smartcase               " Override `ignorecase` where possible
set softtabstop=4           " Sets the number of columns for a TAB
set synmaxcol=190           " Don't even try to highlight stuff that's longer than 190 columns
set tabstop=4               " The width of a TAB is set to 4.
                            " Still it is a \t. It is just that
                            " vim will interpret it to be having
                            " a width of 4.
set termguicolors           " Term supports gui colors
set title                   " Set window title appropriately

if has('nvim')
    set pumblend=15         " Enable a subtle transparency effect on pop-up menu
    set signcolumn=yes:2    " Reserve space for atleast two signs
else
    set signcolumn=yes      " Vim doesn't allow multiple signs
    set ttyfast             " Fast scroll hax
endif

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
" MAPPINGS
"==============================================================================
"{{{

" No need to keep holding shift
nnoremap ; :
xnoremap ; :

" Map H and L to start and end of the line respectively (makes more sence that way)
noremap H 0
noremap L $

" Navigating between windows
nnoremap <silent> <C-Up> :wincmd k<CR>
nnoremap <silent> <C-Down> :wincmd j<CR>
nnoremap <silent> <C-Left> :wincmd h<CR>
nnoremap <silent> <C-Right> :wincmd l<CR>

" Moving windows
nnoremap <silent> <C-S-Up> :wincmd K<CR>
nnoremap <silent> <C-S-Down> :wincmd J<CR>
nnoremap <silent> <C-S-Left> :wincmd H<CR>
nnoremap <silent> <C-S-Right> :wincmd L<CR>

" Quick moving around while keeping the cursor fixed in middle
nnoremap <silent> J 5jzz
nnoremap <silent> K 5kzz

" Toggle tab highlighting
nnoremap <silent> <Leader>th :call ToggleTabHighlight()<CR>

" Toggle search highlighting
nnoremap <silent> <Leader>sh :set hlsearch!<CR>

" Buffer management
nnoremap <silent> <Leader>n :bnext<CR>
nnoremap <silent> <Leader>p :bprevious<CR>
nnoremap <silent> <C-w> :bdelete<CR>

" Quick edit/source init.vim/vimrc and coc-settings.json
nnoremap <silent> <expr> <Leader>ev has('nvim') ?
    \ ":edit $MYVIMRC<CR>" : ":edit ~/.vim/init.vim<CR>"
nnoremap <silent> <Leader>es :CocConfig<CR>
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>

" Quick edit my dotfiles
nnoremap <silent> <Leader>ed :edit ~/env/dotfiles<CR>

if has('nvim')

    " Make <Esc> to actually escape from terminal mode
    tnoremap <silent> <Esc> <C-\><C-n>

endif

"}}}

"==============================================================================
" FUNCTIONS
"==============================================================================
"{{{

" Toggle tab highlighting
function! ToggleTabHighlight()
    if g:tab_highlight == 1
        hi clear Tabs
        let g:tab_highlight = 0
    else
        hi Tabs ctermbg=yellow guibg=#FFFF00
        let g:tab_highlight = 1
    endif
endfunc


"}}}

"==============================================================================
" [AUTO]COMMANDS
"==============================================================================
"{{{

" Wrap global autocmds in group
augroup my_init_augroup
    autocmd!

    " Only highlight colorcolumn and cursorline on active window
    autocmd WinLeave * set nocursorline colorcolumn=
    autocmd WinEnter * set cursorline colorcolumn=80

    if has('nvim')
        " Need no numbers in terminal
        autocmd TermOpen * set nonumber norelativenumber signcolumn=no

        " Highlight text on yank
        autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=400}
    endif

augroup END

"}}}
