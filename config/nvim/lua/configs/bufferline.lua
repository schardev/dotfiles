require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        offsets = { { filetype = "NvimTree", text = "File Explorer" } },
    },
    highlights = {
        -- Color of current selected buffer
        close_button_selected = {
            fg = {
                attribute = "fg",
                highlight = "Error",
            },
        },
    },
})
