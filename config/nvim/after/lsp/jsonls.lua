---@type vim.lsp.Config
return {
  -- https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server#settings
  ---@type lspconfig.settings.jsonls
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
    },
  },
}
