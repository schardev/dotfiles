" Disable color column
setlocal colorcolumn=

" Wrap text by default and don't break words
setlocal wrap linebreak

" Open help page of word under cursor
nnoremap <buffer> <silent> D :execute 'h ' . expand('<cword>')<CR>
