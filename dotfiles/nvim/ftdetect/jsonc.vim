" Taken from https://github.com/kevinoid/vim-jsonc
augroup jsoncFtdetect
    autocmd!
    autocmd BufNewFile,BufRead *.cjsn setfiletype jsonc
    autocmd BufNewFile,BufRead *.cjson setfiletype jsonc
    autocmd BufNewFile,BufRead *.jsonc setfiletype jsonc
    autocmd BufNewFile,BufRead .eslintrc.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead .jshintrc setlocal filetype=jsonc
    autocmd BufNewFile,BufRead .mocharc.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead .mocharc.jsonc setlocal filetype=jsonc
    autocmd BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead settings.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead coffeelint.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead */waybar/config setlocal filetype=jsonc
augroup END
