local M = {}

-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
M.config = {
  settings = {
    typescript = {
      -- https://code.visualstudio.com/docs/typescript/typescript-editing#_inlay-hints
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
    },
    vtsls = {
      experimental = {
        -- Truncate inlay hint
        -- https://github.com/neovim/neovim/issues/27240
        maxInlayHintLength = 40,
        completion = {
          -- Execute fuzzy match of completion items on server side. Enable this
          -- will help filter out useless completion items from tsserver
          enableServerSideFuzzyMatch = true,
          -- entriesLimit = 200,
        },
      },
    },
  },
}

return M
