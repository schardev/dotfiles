require("catppuccin").setup({
    no_italic = true,

    -- use lighter color for comments so that I can actually *see* them
    highlight_overrides = {
        mocha = function(colors)
            return {
                ["@comment"] = { fg = colors.overlay1 },
                VertSplit = { fg = colors.overlay1 },
            }
        end,
    },
    styles = {
        comments = { "italic" },
    },
    integrations = {
        lsp_trouble = true,
        leap = true,
        which_key = true,
    },
})
