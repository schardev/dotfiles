return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    vim.api.nvim_create_autocmd(
      "VimLeavePre",
      { command = [[silent! FidgetClose]] }
    )

    require("fidget").setup({
      notification = {
        override_vim_notify = true,
        window = {
          winblend = 25,
        },
      },
    })
  end,
}
