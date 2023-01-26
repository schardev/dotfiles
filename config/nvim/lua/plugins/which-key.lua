return {
  "folke/which-key.nvim",
  event = "BufEnter",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    })

    -- Register few groups
    wk.register({
      ["<leader>"] = {
        e = { name = "+edit" },
        g = { name = "+git" },
        n = { g = { name = "+neogen" } },
        r = { name = "+replace" },
        s = { name = "+telescope" },
      },
    })
  end,
}
