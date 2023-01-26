return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  opts = {
    -- char list for different indentation level
    char_list = { "|", "¦", "┆", "┊" },

    -- Ignore indent lines on these filetypes/buftype
    filetype_exclude = {
      "NvimTree",
      "help",
      "lsp-installer",
      "markdown",
      "packer",
      "startify",
    },
    buftype_exclude = { "terminal", "nofile" },

    -- Show indent context like VSCode (requires treesitter)
    show_current_context = true,
    -- show_current_context_start = true,

    show_trailing_blankline_indent = false,

    -- Use treesitter to calculate indent
    use_treesitter = true,
  },
}
