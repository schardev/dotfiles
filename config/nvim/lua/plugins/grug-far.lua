---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  config = function()
    require("grug-far").setup({})
  end,
}
