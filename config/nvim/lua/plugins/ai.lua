---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    ft = { "gitcommit" },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { gitcommit = true },
    },
  },

  ---@module 'codecompanion'
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        mode = { "n", "v" },
        "<leader>ai",
        "<cmd>CodeCompanion<cr>",
        desc = "AI: Inline assistant",
      },
      {
        mode = { "n", "v" },
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        desc = "AI: Actions",
      },
      {
        mode = { "n", "v" },
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "AI: Toggle Chat",
      },
    },
    opts = {
      strategies = {
        chat = {
          roles = {
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter)
              return ("%s (%s)"):format(
                adapter.formatted_name,
                adapter.model.name
              )
            end,

            ---The header name for your messages
            ---@type string
            user = "Me",
          },
        },
      },
    },
  },
}
