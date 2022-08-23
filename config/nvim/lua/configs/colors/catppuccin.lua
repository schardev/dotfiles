vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette

require("catppuccin").setup({
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    -- use lighter color for comments so that I can actually *see* them
    custom_highlights = {
        Comment = { fg = colors.overlay1 },
        VertSplit = { fg = colors.overlay1 },
    },
    styles = {
        comments = { "italic" },
        conditionals = {},
    },
    integrations = {
        lsp_trouble = true,
        leap = true,
        which_key = true,
    },
})
