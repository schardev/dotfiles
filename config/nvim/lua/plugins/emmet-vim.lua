return {
  "mattn/emmet-vim",
  ft = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
  },
  enabled = false, -- FIXME: disabled because it fucks up spell (ik, kinda weird)
  config = function()
    local mapper = require("core.utils").mapper_factory
    -- Wrap selected text in emmet abbrev
    mapper("v")("<leader>S", "<C-y>,", { remap = true })
  end,
}
