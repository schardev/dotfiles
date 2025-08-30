return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "nvim-autopairs",
    "saadparwaiz1/cmp_luasnip",
    {
      "petertriho/cmp-git",
      config = true,
    },
    {
      "zbirenbaum/copilot-cmp",
      config = true,
    },
  },
  config = function()
    -- nvim-cmp setup
    local utils = require("core.utils")
    local autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    local cmp_kinds = require("cmp.types").lsp.CompletionItemKind
    local luasnip = require("luasnip")
    local cmp_kind_icons = require("core.icons").lspkind

    local cmp_source_names = {
      copilot = "[Copilot]",
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      git = "[Git]",
      calc = "[Calc]",
      spell = "[Spell]",
    }

    local common_sources = {
      { name = "copilot" },
      { name = "buffer", max_item_count = 10 },
      { name = "calc" },
      { name = "path" },
      {
        name = "spell",
        option = {
          enable_in_context = function()
            return require("cmp.config.context").in_treesitter_capture("spell")
          end,
        },
      },
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = function(entry, vim_item)
          local source_name = cmp_source_names[entry.source.name]

          vim_item.kind =
            string.format("%s %s", cmp_kind_icons[vim_item.kind], vim_item.kind)
          vim_item.menu = source_name

          return vim_item
        end,
      },

      window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/17#issuecomment-1291205911
      preselect = cmp.PreselectMode.None,

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
            -- Need the `Select` behaviour due to below issue
            -- https://github.com/typescript-language-server/typescript-language-server/issues/917#issuecomment-2379364927
            cmp.select_next_item({
              behavior = cmp.SelectBehavior.Select,
            })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({
              behavior = cmp.SelectBehavior.Select,
            })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
      }, common_sources),
    })

    -- Autopairs for completion items
    cmp.event:on("confirm_done", autopairs.on_confirm_done())

    -- Enable emmet-ls snippets inside jsx only
    -- https://github.com/hrsh7th/nvim-cmp/issues/806#issuecomment-1207815660
    local is_emmet_snippet = function(entry)
      return entry:get_kind() == cmp_kinds.Snippet
        and entry.source:get_debug_name() == "nvim_lsp:emmet_language_server"
    end

    local emmet_in_jsx_only = function(entry, _)
      if is_emmet_snippet(entry) then
        local node = vim.treesitter.get_node()
        return node
            and (node:type() == "jsx_element" or node:type() == "jsx_text")
          or false
      end
      return true
    end

    local emmet_in_html_block_only = function(entry, _)
      if not is_emmet_snippet(entry) then
        return true
      end

      return utils.get_lang_from_cursor_pos() == "html"
    end

    -- Add filtered lsp source to jsx supported files
    -- TODO: https://github.com/hrsh7th/nvim-cmp/issues/632
    cmp.setup.filetype({ "javascriptreact", "typescriptreact" }, {
      sources = cmp.config.sources({
        { name = "luasnip", keyword_length = 2, max_item_count = 5 },
        { name = "nvim_lsp", entry_filter = emmet_in_jsx_only },
        { name = "nvim_lsp_signature_help" },
      }, common_sources),
    })

    -- Make <CR> autoselect first completion item in html files
    cmp.setup.filetype("html", {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
    })

    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp", entry_filter = emmet_in_html_block_only },
      }, common_sources),
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, common_sources),
    })
  end,
}
