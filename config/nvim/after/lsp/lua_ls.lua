---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Disable",
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
