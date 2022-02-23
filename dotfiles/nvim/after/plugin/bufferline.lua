local installed, _ = pcall(require, "bufferline")

if not installed then
    return
end

require("bufferline").setup {
    options = {
        diagnostics = "coc",
        separator_style = "thick",
        offsets = {{ filetype = "NvimTree", text = "File Explorer" }},
    }
}
