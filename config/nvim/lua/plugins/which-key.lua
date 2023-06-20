return {
  "folke/which-key.nvim",
  event = "BufEnter",
  config = function()
    local wk = require("which-key")

    wk.setup({
      window = {
        margin = { 1, 0, 2, 0 },
      },
    })

    -- Register few groups
    wk.register({
      ["<leader>"] = {
        e = { name = "+edit" },
        g = { name = "+git" },
        n = { g = { name = "+neogen" } },
        r = { name = "+replace" },
        f = { name = "+telescope" },
      },
    })
  end,
}
