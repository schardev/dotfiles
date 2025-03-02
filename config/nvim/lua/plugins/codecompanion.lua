---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local map = require("core.utils").map

      map({ "n", "v" }, "<Leader>ai", "<cmd>CodeCompanion<cr>")
      map({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionActions<cr>")
      map({ "n", "v" }, "<Leader>ac", "<cmd>CodeCompanionChat Toggle<cr>")

      require("codecompanion").setup({
        -- strategies = {
        --   chat = { adapter = "anthropic" },
        --   inline = { adapter = "anthropic" },
        -- },
      })
    end,
  },
}
