---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "mason.nvim" },
  config = function()
    local map = require("core.utils").map
    local conform = require("conform")
    local ignore_filetypes = {}
    vim.g.format_on_save = true
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    map({ "n", "v" }, "<LocalLeader>F", function()
      require("conform").format({
        formatters = { "injected" },
        timeout_ms = 3000,
      })
    end, "Format injected")

    map({ "n", "v" }, "<LocalLeader>f", function()
      require("conform").format()
    end, "Format")

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = vim.api.nvim_create_augroup(
        "user.plugin.conform",
        { clear = true }
      ),
      callback = function(args)
        local available_formatters =
          require("conform").list_formatters(args.buf)

        if #available_formatters > 0 then
          vim.b[args.buf].format_on_save = true
        end
      end,
      desc = "Enable format on save",
    })

    vim.api.nvim_create_user_command("UserAutoFormatToggle", function(args)
      local ref = vim.g
      local scope = "globally"
      if args.bang then
        -- UserAutoFormatToggle! will disable formatting for current buffer
        ref = vim.b
        scope = "locally"
      end

      if not ref.format_on_save then
        ref.format_on_save = true
      else
        ref.format_on_save = false
      end

      vim.notify(
        string.format(
          "%s auto-formatting %s",
          ref.format_on_save and "Enabled" or "Disabled",
          scope
        )
      )
    end, { desc = "Toggle auto-formatting", bang = true })

    ---@type conform.FiletypeFormatter
    local prettier = {
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

    conform.setup({
      -- log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        bash = { "shfmt" },
        css = prettier,
        html = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        lua = { "stylua" },
        markdown = prettier,
        sass = prettier,
        scss = prettier,
        sh = { "shfmt" },
        typescript = prettier,
        typescriptreact = prettier,
        yaml = prettier,
        -- run on files that don't have other formatters configured
        ["_"] = { "trim_newlines", "trim_whitespace" },
      },
      formatters = {
        shfmt = {
          append_args = {
            "-ci", -- format case statements
            "-i",
            "4", -- indents will have width of 4 spaces
          },
        },
        injected = {
          options = {
            ignore_errors = true,
          },
        },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat if turned off
        if not vim.g.format_on_save or not vim.b[bufnr].format_on_save then
          return
        end

        -- Disable autoformat on certain filetypes
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return {
          -- These options will be passed to conform.format()
          timeout_ms = 3000,
          lsp_format = "fallback",
        }
      end,
      -- log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
    })
  end,
}
