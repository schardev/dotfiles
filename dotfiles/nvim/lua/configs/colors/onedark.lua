require("onedark").setup({
    style = "darker",
    -- toggle_style_key = "<leader>ts",

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
    },
})
