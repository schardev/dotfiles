local installed, _ = pcall(require, "bufferline")

if not installed then
    return
end

-- Onedark colors
local colors = require("onedark.colors")

require("bufferline").setup {
    options = {
        diagnostics = "coc",
        separator_style = "thick",
        offsets = { { filetype = "NvimTree", text = "File Explorer" } },
    },
    highlights = {
        -- Color of current selected buffer
        close_button_selected = {
            guifg = colors.red,
        },
    },
}
