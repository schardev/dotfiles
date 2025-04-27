---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { mode = { "n", "v" }, "<Leader>ai", "<cmd>CodeCompanion<cr>" },
      { mode = { "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionActions<cr>" },
      {
        mode = { "n", "v" },
        "<Leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
      },
    },
    opts = {
      -- strategies = {
      --   chat = { adapter = "anthropic" },
      --   inline = { adapter = "anthropic" },
      -- },
    },
  },
}
