require("catppuccin").setup({
    term_colors = false,
    styles = {
        comments = "italic",
        functions = "NONE",
        keywords = "italic",
        strings = "NONE",
        variables = "NONE",
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = "italic",
                hints = "italic",
                warnings = "italic",
                information = "italic",
            },
            underlines = {
                errors = "undercurl",
                hints = "NONE",
                warnings = "underline",
                information = "NONE",
            },
        },
        lsp_trouble = false,
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = false,
            transparent_panel = false,
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        dashboard = true,
        bufferline = true,
        markdown = true,
        ts_rainbow = false,
        notify = true,
    },
})
