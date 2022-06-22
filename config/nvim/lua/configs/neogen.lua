local neogen = require("neogen")
local nnoremap = require("core.utils").nnoremap

neogen.setup({
    snippet_engine = "luasnip",
})

-- Mappings
nnoremap("<Leader>ng", neogen.generate, { desc = "Generate annotation" })
