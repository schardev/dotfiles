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
Plug 'ap/vim-css-color'                                 " CSS color preview
Plug 'psliwka/vim-smoothie'                             " Smoothie
Plug 'airblade/vim-gitgutter'                           " Shows modified lines in number column

if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim'          " Indent level
endif

call plug#end()

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

" Toggle tab highlighting
nnoremap <silent> <Leader>t :call ToggleTabHighlight()<CR>

" Toggle search highlighting
nnoremap <silent> <Leader>s :set hlsearch!<CR>

" Buffer management
nnoremap <silent> <Leader>n :bnext<CR>
nnoremap <silent> <Leader>p :bprevious<CR>
nnoremap <silent> <C-d> :bdelete<CR>

" Quick edit/source init.vim/vimrc
nnoremap <silent> <expr> <Leader>ev has('nvim') ?
    \ ":call FloatingWindow('edit', '$MYVIMRC')<CR>" :
    \ ":edit ~/.vim/init.vim<CR>"
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>

" Quick edit my dotfiles
nnoremap <silent> <expr> <Leader>ed has('nvim') ?
    \ ":call FloatingWindow('edit', '~/env/dotfiles')<CR>" :
    \ ":edit ~/env/dotfiles<CR>"

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
    elseif g:tab_highlight == 0
        hi Tabs ctermbg=yellow guibg=#FFFF00
        let g:tab_highlight = 1
    endif
endfunc

" Creates a bordered floating window
" NOTE: Only works with nvim!
function! CreateCenteredFloatingWindow(title) abort
    " Define size of the float window
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
      \ 'relative': 'editor',
      \ 'row': top,
      \ 'col': left,
      \ 'width': width,
      \ 'height': height,
      \ 'style': 'minimal',
      \ 'focusable': v:false
    \ }

    " Create a 'bordered' window
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰─" . a:title . repeat("─", width - strlen(a:title) - 3) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let border_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(border_bufnr, 0, -1, v:true, lines)

    let s:border_winid = nvim_open_win(border_bufnr, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let opts.focusable = v:true
    let text_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_open_win(text_bufnr, v:true, opts)
    autocmd WinClosed * ++once :bdelete | call nvim_win_close(s:border_winid, v:true)
    return text_bufnr
endfunction

function! FloatingWindow(command, argument) abort
    let l:buf = CreateCenteredFloatingWindow(a:argument)
    execute a:command . a:argument
endfunction

"}}}
"
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
