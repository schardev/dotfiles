local neogen = require("neogen")
local nnoremap = require("core.utils").nnoremap

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
