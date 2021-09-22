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
nnoremap <silent> <Leader>N :bprevious<CR>
nnoremap <silent> <C-d> :bdelete<CR>

" Quick moving around
nmap <silent> J <Plug>(SmoothieDownwards)
nmap <silent> K <Plug>(SmoothieUpwards)

" Quick edit/source init.vim/vimrc
nnoremap <silent> <expr> <Leader>ev has('nvim') ?
    \ ":call FloatingWindow('edit', '$MYVIMRC')<CR>" :
    \ ":edit ~/.vim/init.vim<CR>"
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
