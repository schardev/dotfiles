return {
  "folke/which-key.nvim",
  event = "BufEnter",
  opts = {
    delay = 400,
    icons = { rules = false },
    spec = {
      { "<leader>e", desc = "+edit" },
      { "<leader>g", desc = "+git" },
      { "<leader>ng", desc = "+neogen" },
      { "<leader>r", desc = "+replace" },
      { "<leader>f", desc = "+telescope" },
    },
  },
}
