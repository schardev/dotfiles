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
    local nnoremap = require("core.utils").mapper_factory("n")

    neogen.setup({
      snippet_engine = "luasnip",
    })

    -- Supported annotations are func, class, type, file
    nnoremap("<Leader>ngf", function()
      neogen.generate({ type = "func" })
    end, { desc = "Annotate func" })

    nnoremap("<Leader>ngc", function()
      neogen.generate({ type = "class" })
    end, { desc = "Annotate class" })

    nnoremap("<Leader>ngt", function()
      neogen.generate({ type = "type" })
    end, { desc = "Annotate type" })
  end,
}
