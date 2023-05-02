return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local ft_funs = require("luasnip.extras.filetype_functions")
    local map = require("core.utils").mapper_factory({ "i", "s" })

    map("<M-Tab>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    ls.config.setup({
      -- history = true, -- If true, snippets that were exited can still be jumped back into
      update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = { "TextChanged", "TextChangedI" },
      store_selection_keys = "s",
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticSignInfo" } },
          },
        },
      },
      ft_func = function()
        if vim.bo.filetype == "markdown" then
          return ft_funs.from_pos_or_filetype()
        else
          return ft_funs.from_filetype()
        end
      end,
      load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
        markdown = {
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "lua",
          "scss",
          "typescript",
          "typescriptreact",
        },
      }),

      -- globally available utility functions
      snip_env = {
        insert_selected_text = function(jump_index, default_snip)
          return ls.d(jump_index, function(_, snip)
            local selected_text = snip.env.LS_SELECT_RAW

            if not vim.tbl_isempty(selected_text) then
              return ls.sn(nil, {
                ls.t(vim.tbl_flatten({ selected_text, "" })),
                ls.i(1),
              })
            else
              return default_snip or ls.sn(nil, { ls.i(1) })
            end
          end)
        end,
        insert_filename = function()
          return ls.f(function(_, snip)
            return snip.env.TM_FILENAME_BASE
          end)
        end,
      },
    })

    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("javascriptreact", { "javascript" })
    ls.filetype_extend(
      "typescriptreact",
      { "javascriptreact", "javascript", "typescript" }
    )

    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = vim.env.CONFIG_DIR .. "/vscode/snippets",
    })
  end,
}
