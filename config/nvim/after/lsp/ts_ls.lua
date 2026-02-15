---@type vim.lsp.Config
return {
  -- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
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
  },
}
