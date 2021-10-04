" Center startify header
let g:startify_custom_header = 'startify#center(startify#fortune#cowsay())'

" Bookmark $MYVIMRC on startify for quick edit
let g:startify_bookmarks = [
        \ {'v': '$MYVIMRC'},
        \ {'d': '~/env/dotfiles'}
        \ ]

let g:startify_commands = [
        \ {'ch': ['Check Health', ':checkhealth']},
        \ {'pi': ['Plug Install', ':PlugInstall']},
        \ {'ps': ['Plugin Stats', ':PlugStatus']},
        \ {'pu': ['Plugin Update', ':PlugUpdate | PlugUpgrade']},
        \ ]

" Open startify when there's no buffer left
" https://github.com/mhinz/vim-startify/issues/424#issuecomment-704865423
augroup startify
    autocmd!
    autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif
augroup END
