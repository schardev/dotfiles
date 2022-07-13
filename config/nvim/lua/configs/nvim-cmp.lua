-- nvim-cmp setup
local autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local luasnip = require("luasnip")
local ts_utils = require("nvim-treesitter.ts_utils")

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
        { name = "luasnip" },
        { name = "nvim_lsp", max_item_count = 30 },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", max_item_count = 10 },
        { name = "path" },
    },
})

-- Autopairs for completion items
-- @see https://github.com/NvChad/NvChad/pull/1095
cmp.event:on("confirm_done", function(event)
    local filetypes =
        { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    local filetype = vim.bo.filetype
    local node_type = ts_utils.get_node_at_cursor():type()

    -- Do not complete autopairs in import statements
    if vim.tbl_contains(filetypes, filetype) then
        if node_type ~= "named_imports" then
            autopairs.on_confirm_done()(event)
        end
    else
        autopairs.on_confirm_done()(event)
    end
end)

-- Make <CR> autoselect first completion item in html files
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
