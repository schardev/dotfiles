return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  tag = "legacy",
  config = function()
    vim.api.nvim_create_autocmd(
      "VimLeavePre",
      { command = [[silent! FidgetClose]] }
    )

    require("fidget").setup({
      text = {
        spinner = "dots",
      },
    })
  end,
}
