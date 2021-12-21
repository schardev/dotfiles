" Set indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" wrap text for html files
setlocal wrap

" No need to keep an eye on line width
setlocal colorcolumn=

" Make <CR> auto-select the first completion item
inoremap <silent> <expr> <CR> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
