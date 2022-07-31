vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette

require("catppuccin").setup({
    transparent_background = false,
    term_colors = false,
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
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = {},
                warnings = { "italic" },
                information = {},
            },
            underlines = {
                errors = { "underline" },
                hints = {},
                warnings = { "underline" },
                information = {},
            },
        },
        lsp_trouble = true,
        cmp = true,
        gitgutter = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = true,
            enable_ui = true,
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = true,
        bufferline = true,
        markdown = true,
        ts_rainbow = false,
    },
})
