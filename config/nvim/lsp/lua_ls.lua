vim.lsp.config("lua_ls", {
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
})
