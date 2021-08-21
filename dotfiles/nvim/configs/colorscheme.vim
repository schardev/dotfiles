" Use a  darker backgroup for onedark
let g:onedark_color_overrides = {
\ "background": {"gui": "#1c1c1c", "cterm": "234", "cterm16": "0" },
\}

" Change colorscheme to onedark if installed
if !empty(glob('$HOME/.config/nvim/plugged/onedark.vim'))
    colorscheme onedark
endif
