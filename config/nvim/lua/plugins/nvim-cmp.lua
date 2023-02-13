return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "nvim-autopairs",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-calc",
    {
      "petertriho/cmp-git",
      config = true,
    },
  },
  config = function()
    -- nvim-cmp setup
    local autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    local cmp_kinds = require("cmp.types").lsp.CompletionItemKind
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
          vim_item.kind =
            string.format("%s %s", cmp_kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            git = "[Git]",
            calc = "[Calc]",
          })[index.source.name]
          return vim_item
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.close()
          else
            cmp.complete()
          end
        end),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace, -- replaces currently typed text with completion entry
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
      sources = cmp.config.sources({
        { name = "luasnip" },
      }, {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
      }, {
        { name = "buffer", max_item_count = 10 },
      }, {
        { name = "calc" },
        { name = "path" },
      }),
    })

    -- Autopairs for completion items
    ---@see https://github.com/NvChad/NvChad/pull/1095
    local ecma_filetypes =
      { "javascript", "typescript", "javascriptreact", "typescriptreact" }

    cmp.event:on("confirm_done", function(event)
      -- Do not complete autopairs in import statements
      local filetype = vim.bo.filetype
      if
        vim.tbl_contains(ecma_filetypes, filetype)
        and ts_utils.get_node_at_cursor():type() == "named_imports"
      then
        return
      end
      autopairs.on_confirm_done()(event)
    end)

    -- Enable emmet-ls snippets inside jsx only
    ---@see https://github.com/hrsh7th/nvim-cmp/issues/806#issuecomment-1207815660
    local is_emmet_snippet = function(entry)
      return cmp_kinds[entry:get_kind()] == "Snippet"
        and entry.source:get_debug_name() == "nvim_lsp:emmet_ls"
    end

    local is_inside_jsx = function()
      local current_node = ts_utils.get_node_at_cursor()

      while current_node ~= nil do
        if current_node:type() == "jsx_text" then
          return true
        end
        current_node = current_node:parent()
      end
      return false
    end

    local emmet_in_jsx_only = function(entry, _)
      if is_emmet_snippet(entry) then
        return is_inside_jsx()
      else
        return true
      end
    end

    local ecma_sources = {
      sources = cmp.config.sources({
        { name = "luasnip" },
      }, {
        { name = "nvim_lsp", entry_filter = emmet_in_jsx_only },
        { name = "nvim_lsp_signature_help" },
      }, {
        { name = "buffer", max_item_count = 10 },
      }, {
        { name = "calc" },
        { name = "path" },
      }),
    }

    -- Add filtered lsp source to jsx supported files
    cmp.setup.filetype({ "javascriptreact", "typescriptreact" }, ecma_sources)

    -- Make <CR> autoselect first completion item in html files
    cmp.setup.filetype("html", {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
    })

    cmp.setup.filetype("gitcommit", {
      sources = {
        { name = "git" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
