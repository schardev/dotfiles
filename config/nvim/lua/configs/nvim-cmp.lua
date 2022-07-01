-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Kind symbols
local cmp_kind_icons = {
    Class = "ﴯ",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "ﰠ",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Property = "ﰠ",
    Reference = "",
    Snippet = "",
    Struct = "פּ",
    Text = "",
    TypeParameter = "",
    Unit = "塞",
    Value = "",
    Variable = "",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(index, vim_item)
            vim_item.kind = string.format(
                "%s %s",
                cmp_kind_icons[vim_item.kind],
                vim_item.kind
            ) -- This concatonates the icons with the name of the item kind

            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                cmp_git = "[Git]",
            })[index.source.name]
            return vim_item
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    -- view = {
    --     entries = "native",
    -- },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp", max_item_count = 30 },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", max_item_count = 10 },
        { name = "path" },
    },
})

-- Autopairs for completion items
cmp.event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
)

cmp.setup.filetype("html", {
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = {
        { name = "cmp_git" },
        { name = "buffer" },
        { name = "path" },
    },
})
