---@type LazySpec
return {
  -- "numToStr/Comment.nvim",
  "neovim-plugins/comment.nvim",
  enabled = true,
  keys = {
    "gcc",
    "gbc",
    { "gc", mode = "v" },
    { "gb", mode = "v" },
  },
  dependencies = {
    -- better comment support for jsx/tsx
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        vim.g.skip_ts_context_commentstring_module = true
        require("ts_context_commentstring").setup({
          enable_autocmd = false,
        })
      end,
    },
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
