return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  dependencies = { "mason.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local utils = require("null-ls.utils")

    local actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    -- Filetypes to trim whitespace and newlines
    local trim_filetypes = {
      "dosini",
      "text",
      "toml",
      "vim",
      "zsh",
      "scss", -- prettier doesn't trim trailing whitespaces for whatever reason
    }

    -- Enable specific formatters only if the root has config file
    local eslint_condition = function()
      return utils.root_pattern(
        -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json"
        -- "package.json"
      )(vim.api.nvim_buf_get_name(0)) ~= nil
    end

    -- TODO: Remove once this gets merged - https://github.com/mantoni/eslint_d.js/issues/214
    local eslint_flat_config = function()
      return utils.root_pattern("eslint.config.js")(
        vim.api.nvim_buf_get_name(0)
      ) ~= nil
    end

    local stylua_condition = function()
      return utils.root_pattern(".stylua.toml", "stylua.toml")(
        vim.api.nvim_buf_get_name(0)
      ) ~= nil
    end

    local sources = {
      --------------------------------
      ---       CODE ACTIONS       ---
      --------------------------------

      actions.eslint_d.with({
        condition = eslint_condition,
      }),

      actions.eslint.with({
        condition = eslint_flat_config,
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

      diagnostics.eslint.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        condition = eslint_flat_config,
      }),

      ------------------------------
      ---       FORMATTING       ---
      ------------------------------

      formatting.prettierd,

      formatting.stylua.with({
        condition = stylua_condition,
      }),

      formatting.trim_newlines.with({
        filetypes = trim_filetypes,
      }),

      formatting.trim_whitespace.with({
        filetypes = trim_filetypes,
      }),

      formatting.shfmt.with({
        extra_args = {
          "-ci", -- format case statements
          "-i",
          "4", -- indents will have width of 4 spaces
        },
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
