require("bufferline").setup({
    options = {
        diagnostics = "coc",
        separator_style = "thick",
        offsets = { { filetype = "NvimTree", text = "File Explorer" } },
    },
    highlights = {
        -- Color of current selected buffer
        close_button_selected = {
            guifg = "red",
        },
    },
})
