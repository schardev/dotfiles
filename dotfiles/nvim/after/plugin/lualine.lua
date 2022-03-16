local installed, _ = pcall(require, "lualine")

if not installed then
    return
end

local get_color = require("lualine.utils.utils").extract_highlight_colors

require("lualine").setup {
    options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "NvimTree" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            { "branch", icon = "שׂ" },
            {
                "diagnostics",

                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
                sources = { "coc", "ale" },

                -- Displays diagnostics for the defined severity types
                sections = { "error", "warn", "info", "hint" },

                -- Highlight groups for diagnostics
                diagnostics_color = {
                    error = { fg = get_color("DiagnosticError", "fg") },
                    warn = { fg = get_color("DiagnosticWarn", "fg") },
                    info = { fg = get_color("DiagnosticInfo", "fg") },
                    hint = { fg = get_color("DiagnosticHint", "fg") },
                },

                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },

                -- Show diagnostics even if there are none
                -- always_visible = true,
            },
        },
        lualine_c = {
            {
                "filename",
                color = { gui = "italic" },
                symbols = { readonly = " " },
            },
        },
        lualine_x = {
            {
                "fileformat",

                -- Disable icon for unix files only
                symbols = { unix = "" },
            },
            "filetype",
        },
        lualine_y = {},
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    -- extensions = {},
}
