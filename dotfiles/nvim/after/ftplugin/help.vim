" Disable color column
setlocal colorcolumn=

" Map `n` to go to next match (works only with :helpg[rep])
nnoremap <silent> <buffer> n :cnext<CR>
nnoremap <silent> <buffer> N :cprevious<CR>

" Clear tab highlighting
highlight clear Tabs
