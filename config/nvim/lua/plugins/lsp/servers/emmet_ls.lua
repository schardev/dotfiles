local M = {}

M.config = {
  filetypes = {
    "html",
    "javascriptreact",
    "markdown",
    "typescriptreact",
    "css",
  },

  -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
        ["bem.modifier"] = "--",
      },
    },
    jsx = {
      options = {
        ["bem.enabled"] = true,
        ["jsx.enabled"] = true,
        ["output.selfClosingStyle"] = "xhtml",
      },
    },
  },
}

return M
