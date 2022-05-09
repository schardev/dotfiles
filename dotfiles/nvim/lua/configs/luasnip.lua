local luasnip = require("luasnip")
local i = luasnip.insert_node
local s = luasnip.snippet
local t = luasnip.text_node
local l = require("luasnip.extras").lambda

luasnip.config.setup({
    store_selection_keys = "s",
})

require("luasnip.loaders.from_vscode").lazy_load({
    paths = vim.env.HOME .. "/env/dotfiles/vscode/snippets",
})

luasnip.add_snippets("lua", {

    -- comment header
    -- (from lua_snippets)
    s("header 1", {
        t("----------"),
        l(l._1:gsub(".", "-"), 1),
        t({ "----------", "" }),
        t("---       "),
        i(1, "header title"),
        t({ "       ---", "" }),
        t("----------"),
        l(l._1:gsub(".", "-"), 1),
        t({ "----------", "" }),
    }),
})
