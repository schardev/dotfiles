---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "mason.nvim" },
  config = function()
    local lint = require("lint")

    vim.api.nvim_create_user_command("LintInfo", function()
      local linters = lint.get_running()
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
          lint.try_lint()
        end,
      }
    )

    lint.linters_by_ft = {
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      zsh = { "zsh" },
      -- javascript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
    }

    lint.linters.shellcheck.args = {
      "-s",
      "bash",
      "-e", -- Start ignoring below rules:
      -- "SC1090" - Can't follow non-constant source. Use a directive to specify location
      -- "SC1091" - Almost the same reason as above
      "SC1090,SC1091",
      "--format",
      "json",
      "-",
    }
  end,
}
