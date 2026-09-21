---@param item blink.cmp.CompletionItem
local is_emmet_snippet = function(item)
  if item.client_name == "emmet_language_server" then
    return true
  end
  return false
end

local is_jsx_node = function()
  local node = vim.treesitter.get_node()
  return node and (node:type() == "jsx_element" or node:type() == "jsx_text")
    or false
end

local source_priority = {
  snippets = 3,
  lsp = 3,
  path = 2,
  buffer = 1,
  spell = 0,
}

---@param item blink.cmp.CompletionItem
---@param is_inside_jsx boolean
local function item_priority(item, is_inside_jsx)
  -- Rank emmet snippets always higher than any completion item inside JSX nodes
  if is_inside_jsx and is_emmet_snippet(item) then
    return source_priority.snippets + 1
  end
  return source_priority[item.source_id]
end

---@type LazySpec
return {
  "saghen/blink.cmp",
  -- enabled = false,
  version = "1.*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "Kaiser-Yang/blink-cmp-git",
    "ribru17/blink-cmp-spell",
    "alexandre-abrioux/blink-cmp-npm.nvim",
    "fang2hou/blink-copilot",
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = { enabled = false },
    keymap = {
      preset = "default",
      ["<C-n>"] = { "select_next", "show" },
      ["<C-Space>"] = { "show", "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = function()
            -- https://github.com/typescript-language-server/typescript-language-server/issues/917#issuecomment-2379364927
            return not vim.tbl_contains(
              { "typescript", "typescriptreact" },
              vim.bo.filetype
            )
          end,
        },
      },
      menu = {
        winblend = 10,
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "source", gap = 1 },
          },
          components = {
            source = {
              width = { max = 30 },
              highlight = "BlinkCmpSource",
              text = function(ctx)
                local verbose = vim.go.verbose == 1
                local source_name = ctx.source_name
                local client_name = ctx.item.client_name
                return source_name ~= ""
                    and string.format(
                      verbose and "(%s:%s)" or "(%s)",
                      source_name,
                      verbose and client_name or nil
                    )
                  or nil
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded", winblend = 10 },
      },
    },
    snippets = { preset = "luasnip" },
    -- signature = { enabled = true, trigger = { enabled = false } },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      ---@diagnostic disable-next-line: assign-type-mismatch -- blink type issue
      sorts = function()
        local is_inside_jsx = is_jsx_node()

        return {
          -- Sort based on source priority
          -- https://github.com/saghen/blink.cmp/issues/1098#issuecomment-2679295335
          function(a, b)
            local a_priority = item_priority(a, is_inside_jsx)
            local b_priority = item_priority(b, is_inside_jsx)
            if a_priority and b_priority and a_priority ~= b_priority then
              return a_priority > b_priority
            end
          end,
          -- defaults
          "score",
          "sort_text",
        }
      end,
    },
    sources = {
      default = { "copilot", "snippets", "lsp", "spell", "buffer", "path" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        gitcommit = { "lsp", "git", "spell", "buffer", "path" },
        octo = { "git", "spell", "buffer", "path" },
        json = { "lsp", "npm", "path" },
        markdown = { "buffer", "spell", "snippets", "path" },
      },
      providers = {
        lsp = {
          transform_items = function(_, items)
            -- Filter out emmet snippets if we're not inside jsx nodes
            local is_jsx_ft = vim.tbl_contains(
              { "javascriptreact", "typescriptreact" },
              vim.bo.filetype
            )

            if not is_jsx_ft then
              return items
            end

            local is_inside_jsx = is_jsx_node()

            return vim.tbl_filter(function(_item)
              ---@type blink.cmp.CompletionItem
              local item = _item
              if is_emmet_snippet(item) and not is_inside_jsx then
                return false
              end

              return true
            end, items)
          end,
        },
        snippets = {
          min_keyword_length = 1,
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
          end,
        },
        buffer = { min_keyword_length = 1, max_items = 10 },
        spell = {
          name = "Spell",
          module = "blink-cmp-spell",
          opts = {
            max_entries = 5,
            -- Only enable source in `@spell` captures, and disable it in
            -- `@nospell` captures.
            enable_in_context = function()
              local parser = vim.treesitter.get_parser()
              if not parser then
                return true
              end

              local cur_pos = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(
                0,
                cur_pos[1] - 1,
                cur_pos[2] - 1
              )
              local in_spell_capture = false
              for _, cap in ipairs(captures) do
                if cap.capture == "spell" then
                  in_spell_capture = true
                elseif cap.capture == "nospell" then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
        git = {
          module = "blink-cmp-git",
          name = "Git",
          enabled = function()
            return vim.tbl_contains({ "octo", "gitcommit" }, vim.bo.filetype)
          end,
        },
        npm = {
          name = "npm",
          module = "blink-cmp-npm",
          async = true,
          ---@module "blink-cmp-npm"
          ---@type blink-cmp-npm.Options
          ---@diagnostic disable-next-line: missing-fields
          opts = {},
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}
