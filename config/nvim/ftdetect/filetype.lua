vim.filetype.add({
    filename = {
        [".eslintrc.json"] = "jsonc",
        ["coc-settings.json"] = "jsonc",
        ["keybindings.json"] = "jsonc",
    },
    pattern = {
        ["*.cjsn"] = "jsonc",
        ["*.cjson"] = "jsonc",
        [".*/zsh/functions/.*"] = "zsh",
        ["tsconfig.*.json"] = "jsonc",
    },
})
