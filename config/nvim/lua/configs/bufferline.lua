local nnoremap = require("core.utils").mapper_factory("n")

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

-- Mappings
nnoremap("<C-L>", "<Cmd>BufferLineCycleNext<CR>")
nnoremap("<C-H>", "<Cmd>BufferLineCyclePrev<CR>")
