local M = {}

-- https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server#settings
M.config = {
  settings = {
    json = {
      validate = { enable = true },
      schemas = {
        {
          description = "NPM configuration file",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          description = "Babel configuration",
          fileMatch = {
            ".babelrc.json",
            ".babelrc",
            "babel.config.json",
          },
          url = "https://json.schemastore.org/lerna",
        },
        {
          description = "ESLint config",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "https://json.schemastore.org/eslintrc",
        },
        {
          description = "Prettier config",
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json",
          },
          url = "https://json.schemastore.org/prettierrc",
        },
        {
          description = "Vercel Now config",
          fileMatch = { "now.json" },
          url = "https://json.schemastore.org/now",
        },
        {
          description = "Vercel configuration file",
          fileMatch = { "vercel.json" },
          name = "Vercel",
          url = "https://openapi.vercel.sh/vercel.json",
        },
      },
    },
  },
}

return M
