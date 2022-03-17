local installed, _ = pcall(require, "onedark")

if not installed then
    return
end

require("onedark").setup {
    style = "darker",
    -- toggle_style_key = '<leader>ts',
    --
    -- Show the end-of-buffer tildes
    ending_tildes = true,

    -- Custom Highlights
    colors = {
        bg0 = "#0d1117", -- github dark background
    },

    -- Override few highlighting groups
    highlights = {
        Pmenu = { bg = "#181a1f" },
        GitGutterChange = { fg = "$yellow" },
        TSComment = { fg = "$light_grey" },
        Comment = { fg = "$light_grey" },

        -- Treesitter rainbow colors
        rainbowcol1 = { fg = "#e6b422" },
        rainbowcol2 = { fg = "#c70067" },
        rainbowcol3 = { fg = "#00a960" },
        rainbowcol4 = { fg = "#fc7482" },
        rainbowcol5 = { fg = "#33ccff" },
        rainbowcol6 = { fg = "#8080ff" },
        rainbowcol7 = { fg = "#0073a8" },
    },
}

-- Enable colorscheme
require("onedark").load()
