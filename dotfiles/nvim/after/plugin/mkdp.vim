" Do not autoclose preview window
let g:mkdp_auto_close = 0

if ! $IS_TERMUX
    " Default browser to open markdown files
    let g:mkdp_browser = 'firefox'
endif
