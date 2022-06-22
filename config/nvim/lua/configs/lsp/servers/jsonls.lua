local M = {}

M = {
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
                    fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                    url = "http://json.schemastore.org/tsconfig",
                },
                {
                    description = "Babel configuration",
                    fileMatch = {
                        ".babelrc.json",
                        ".babelrc",
                        "babel.config.json",
                    },
                    url = "http://json.schemastore.org/lerna",
                },
                {
                    description = "ESLint config",
                    fileMatch = { ".eslintrc.json", ".eslintrc" },
                    url = "http://json.schemastore.org/eslintrc",
                },
                {
                    description = "Prettier config",
                    fileMatch = {
                        ".prettierrc",
                        ".prettierrc.json",
                        "prettier.config.json",
                    },
                    url = "http://json.schemastore.org/prettierrc",
                },
                {
                    description = "Vercel Now config",
                    fileMatch = { "now.json" },
                    url = "http://json.schemastore.org/now",
                },
            },
        },
    },
}

return M
