---@type LazySpec
return {
  -- indent/scope highlighting
  ---@module 'indent_blankline'
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  ---@type ibl.config
  opts = {
    -- char list for different indentation level
    indent = {
      char = { "|", "¦", "┆", "┊" },
      -- char = { "│" },
    },

    exclude = {
      filetypes = {
        "NvimTree",
        "markdown",
        "startify",
      },
    },

    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
