return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      separator_style = "thick",
      offsets = { { filetype = "NvimTree", text = "File Explorer" } },
    },
    highlights = {
      -- Color of current selected buffer
      close_button_selected = {
        fg = {
          attribute = "fg",
          highlight = "Error",
        },
      },
    },
  },
  keys = {
    -- Mappings
    { "<C-L>", "<Cmd>BufferLineCycleNext<CR>" },
    { "<C-H>", "<Cmd>BufferLineCyclePrev<CR>" },
  },
}
