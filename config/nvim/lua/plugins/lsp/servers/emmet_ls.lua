local M = {}

M.config = {
  -- Disable emmet in css/sass
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    -- "css",
    -- "sass",
    -- "scss",
    -- "less",
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
