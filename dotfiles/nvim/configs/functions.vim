" Toggle tab highlighting
function! ToggleTabHighlight()
    if g:tab_highlight == 1
        hi clear Tabs
        let g:tab_highlight = 0
    elseif g:tab_highlight == 0
        hi Tabs ctermbg=yellow guibg=#FFFF00
        let g:tab_highlight = 1
    endif
endfunc

