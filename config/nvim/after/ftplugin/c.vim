" Hax to prevent c.vim from clearing tabs highlighting for cpp.vim, since vim
" sources c.vim for cpp files as well (see /usr/share/[n]vim/runtime/ftplugin/c.vim)
if (&ft != 'c')
    finish
endif

" Set indentation to match linux-kernel coding style
setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8

" Enable spell
setlocal spell
