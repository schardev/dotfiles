local installed, _ = pcall(require, "onedark")

if not installed then
    return
end

require("onedark").setup {
    style = 'darker',
    -- toggle_style_key = '<leader>ts',

    -- Custom Highlights
    colors = {
        bg0 = '#0d1117' -- github dark background
    },

    -- Override few highlighting groups
    highlights = {
        Pmenu = {bg = "#181a1f"},
        GitGutterChange = {fg = "$yellow"},
        ALEWarningSign = {fg = "$yellow"},
        CocWarningSign = {fg = "$yellow"},
        CocErrorSign = {fg = "$red"}
    },
}

-- Enable colorscheme
require('onedark').load()
