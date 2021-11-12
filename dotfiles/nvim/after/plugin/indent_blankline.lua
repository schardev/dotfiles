require'indent_blankline'.setup {
    -- char list for different indentation level
    char_list = {'|', '¦', '┆', '┊'},

    -- Ignore indent lines on these filetypes/buftype
    filetype_exclude = {'help', 'markdown', 'startify'},
    buftype_exclude = {'terminal'}
}
