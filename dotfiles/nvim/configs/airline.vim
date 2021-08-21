" Enable tabline extension
let g:airline#extensions#tabline#enabled = 1

" Only show file name in bufferline
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Less cluttered Z section
let g:airline_section_z = "%l/%L:%c"

" Disable tabs
let g:airline#extensions#tabline#show_tabs = 0

" Use patched powerline fonts
let g:airline_powerline_fonts = 1

" Custom seperators for statusline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" Don't show tab count in rhs of bufferline
let g:airline#extensions#tabline#show_tab_count = 0

" Don't show tab/buffer split
let g:airline#extensions#tabline#show_splits = 0
