return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local ft_funs = require("luasnip.extras.filetype_functions")
    local map = require("core.utils").map
    local utils = require("core.utils").string_utils

    map({ "i", "s" }, "<M-Tab>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    ls.setup({
      -- TODO: disabled until this gets fixed https://github.com/L3MON4D3/LuaSnip/issues/503
      -- update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = { "TextChanged", "TextChangedI" },
      cut_selection_keys = "s",
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

            if not vim.tbl_isempty({ selected_text }) then
              return ls.sn(nil, {
                ls.t(vim.iter({ selected_text, "" }):flatten():totable()),
                ls.i(1),
              })
            else
              return default_snip or ls.sn(nil, { ls.i(1) })
            end
          end)
        end,
        insert_filename = function(jump_index, insert, case)
          return ls.d(jump_index, function(_, snip)
            local filename = snip.env.TM_FILENAME_BASE

            if case == "pascal" then
              filename = utils.to_pascal_case(filename)
            end

            return ls.sn(nil, { ls.i(insert and 1 or nil, filename) })
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

    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets/luasnippets" },
    })
    require("luasnip.loaders.from_snipmate").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets/snipmate" },
    })
  end,
}
