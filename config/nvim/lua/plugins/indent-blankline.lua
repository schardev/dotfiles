return {
  -- indent/scope highlighting
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
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
