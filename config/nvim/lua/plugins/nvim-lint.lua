---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  config = function()
    vim.api.nvim_create_user_command("LintInfo", function()
      local linters = require("lint").get_running()
      if #linters == 0 then
        return vim.notify("No linters running")
      end
      vim.notify("Linters: " .. table.concat(linters, ", "))
    end, { desc = "Lint info" })

    vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "InsertLeave" },
      {
        group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      }
    )

    require("lint").linters_by_ft = {
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      zsh = { "zsh" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
  end,
}
