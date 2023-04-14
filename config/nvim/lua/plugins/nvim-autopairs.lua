-- Autopairs for bracket completions
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local ts_conds = require("nvim-autopairs.ts-conds")
    local ecma_filetypes =
      { "javascript", "typescript", "javascriptreact", "typescriptreact" }

    autopairs.setup({
      check_ts = true,
    })

    -- https://github.com/windwp/nvim-autopairs/pull/283
    autopairs.get_rule("(").not_filetypes = ecma_filetypes -- first remove the rule in order to override
    autopairs.add_rules({
      -- do not autocomplete parenthesis in import statements
      Rule("(", ")", ecma_filetypes):with_pair(
        ts_conds.is_in_range(function(param)
          if not param then
            return false
          end
          return param.type ~= "named_imports"
        end, function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          return { cursor[1] - 1, cursor[2] }
        end)
      ),

      Rule("$", "$", { "markdown" }),
    })
  end,
}
