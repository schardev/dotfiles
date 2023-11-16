return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-web-devicons" },
  config = function()
    -- For extracting colors from hlgroups
    local get_color = require("lualine.utils.utils").extract_highlight_colors
    local icons = require("core.icons")

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

      tabs = function()
        return not vim.bo.expandtab
      end,
    }

    local components = {
      format_status = function()
        return icons.devicons.format
      end,

      tabs = function()
        return "[TABS]"
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
          { "branch", icon = "󰘬" },
          {
            "diagnostics",

            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
            sources = { "nvim_lsp", "coc", "ale" },

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
              error = string.format("%s ", icons.diagnostics.error),
              warn = string.format("%s ", icons.diagnostics.warning),
              info = string.format("%s ", icons.diagnostics.info),
              hint = string.format("%s ", icons.diagnostics.hint),
            },

            -- Show diagnostics even if there are none
            -- always_visible = true,
          },
        },
        lualine_c = {
          {
            "filename",
            -- color = { gui = "italic" },
            path = 4,
            cond = conditions.buffer_not_empty,
            symbols = {
              modified = " +",
              readonly = string.format(" %s", icons.devicons.lock),
            },
          },
        },
        lualine_x = {
          "filetype",
          {
            "fileformat",

            -- Only show for non-unix files
            cond = conditions.file_not_unix,
          },
          {
            components.tabs,
            cond = conditions.tabs,
            color = {
              fg = get_color("DiagnosticInfo", "fg"),
            },
          },
          "searchcount",
        },
        lualine_y = {
          {
            components.format_status,
            color = function()
              return {
                bg = not vim.b.format_on_save
                  and get_color("NeogitDiffDelete", "bg"),
                fg = not vim.b.format_on_save
                  and get_color("NeogitDiffDelete", "fg"),
              }
            end,
            on_click = function()
              vim.cmd("UserLspAutoFormatToggle")
            end,
          },
        },
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
  end,
}
