---@type LazySpec
return {
  "j-hui/fidget.nvim",
  event = "BufReadPost",
  opts = {
    notification = {
      window = {
        winblend = 25,
      },
    },
  },
}
