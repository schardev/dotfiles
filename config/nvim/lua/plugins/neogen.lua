return {
  "danymat/neogen",
  ft = {
    "javascript",
    "javascriptreact",
    "lua",
    "sh",
    "typescript",
    "typescriptreact",
  },
  dependencies = { "nvim-treesitter" },
  config = function()
    local neogen = require("neogen")
    local map = require("core.utils").map

    neogen.setup({
      snippet_engine = "luasnip",
    })

    -- Supported annotations are func, class, type, file
    map("n", "<Leader>ngf", function()
      neogen.generate({ type = "func" })
    end, "Annotate func")

    map("n", "<Leader>ngc", function()
      neogen.generate({ type = "class" })
    end, "Annotate class")

    map("n", "<Leader>ngt", function()
      neogen.generate({ type = "type" })
    end, "Annotate type")
  end,
}
