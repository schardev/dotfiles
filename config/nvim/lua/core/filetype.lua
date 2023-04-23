vim.filetype.add({
  extension = {
    cjsn = "jsonc",
    cjson = "jsonc",
    mdx = "markdown",
  },
  filename = {
    [".eslintrc.json"] = "jsonc",
    ["coc-settings.json"] = "jsonc",
    ["keybindings.json"] = "jsonc",
  },
  pattern = {
    [".*/zsh/functions/.*"] = "zsh",
    ["tsconfig.*.json"] = "jsonc",
  },
})
