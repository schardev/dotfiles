return {
  "folke/which-key.nvim",
  event = "BufEnter",
  opts = {
    delay = 400,
    icons = { rules = false },
    spec = {
      { "<leader>a", group = "ai" },
      { "<leader>g", group = "git" },
      { "<leader>ng", group = "neogen" },
      { "<leader>r", group = "replace" },
      { "<leader>f", group = "telescope" },
      { "<leader>t", group = "toggle" },
      { "<leader>R", group = "rest" },
      { "<leader>s", group = "session" },
    },
  },
}
