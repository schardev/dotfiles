local M = {}

-- https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server#settings
M.config = {
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
    },
  },
}

return M
