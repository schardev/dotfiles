local installed, _ = pcall(require, "indent_blankline")

if not installed then
    return
end

require("indent_blankline").setup {
    -- char list for different indentation level
    char_list = {'|', '¦', '┆', '┊'},

    -- Ignore indent lines on these filetypes/buftype
    filetype_exclude = {'help', 'markdown', 'startify', 'NvimTree'},
    buftype_exclude = {'terminal'},

    -- Show indent context like VSCode (requires treesitter)
    show_current_context = true,
    -- show_current_context_start = true,

    -- Use treesitter to calculate indent
    -- use_treesitter = true,
}
