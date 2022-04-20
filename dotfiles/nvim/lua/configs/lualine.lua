-- For extracting colors from hlgroups
local get_color = require("lualine.utils.utils").extract_highlight_colors

-- Conditions
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,

    hide_in_width = function()
        return vim.fn.winwidth(0) > 60
    end,

    file_not_unix = function()
        return vim.bo.fileformat ~= "unix"
    end,
}

require("lualine").setup({
    options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
        -- disabled_filetypes = { "NvimTree" },
        always_divide_middle = true,
        globalstatus = true,
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
                cond = conditions.buffer_not_empty,
                symbols = { readonly = " " },
            },
        },
        lualine_x = {
            {
                "fileformat",

                -- Only show for non-unix files
                cond = conditions.file_not_unix,
            },
            "filetype",
        },
        lualine_y = {},
        lualine_z = {
            {
                "location",
                cond = conditions.hide_in_width,
                padding = { right = 0 },
            },
            {
                "%L",
                cond = conditions.hide_in_width,
                padding = { left = 1, right = 1 },
            },
        },
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
})
