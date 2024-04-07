return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = false,
  dependencies = { "mason.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local utils = require("null-ls.utils")

    local actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics

    -- Enable specific formatters only if the root has config file
    local eslint_condition = function()
      return utils.root_pattern(
        -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
        "eslint.config.js"
        -- "package.json"
      )(vim.api.nvim_buf_get_name(0)) ~= nil
    end

    local sources = {
      --------------------------------
      ---       CODE ACTIONS       ---
      --------------------------------

      actions.eslint_d.with({
        condition = eslint_condition,
      }),

      actions.shellcheck,

      --------------------------------
      ---       DIAGNOSTICS        ---
      --------------------------------

      diagnostics.shellcheck.with({
        diagnostics_format = "[SC#{c}] #{m}",
        extra_args = {
          "-s",
          "bash",
          "-e", -- Start ignoring below rules:
          -- "SC1090" - Can't follow non-constant source. Use a directive to specify location
          -- "SC1091" - Almost the same reason as above
          "SC1090,SC1091",
        },
      }),

      diagnostics.eslint_d.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE, -- run eslint on save
        condition = eslint_condition,
      }),
    }

    null_ls.setup({
      debounce = 150,
      debug = false, -- View logs with `:NullLsLog` after setting to true
      diagnostics_format = "[#{c}] #{m}",
      sources = sources,
    })
  end,
}
