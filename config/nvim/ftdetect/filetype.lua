vim.filetype.add({
    filename = {
        [".eslintrc.json"] = "jsonc",
        ["coc-settings.json"] = "jsonc",
        ["keybindings.json"] = "jsonc",
        ["tsconfig.json"] = "jsonc",
        ["sxhkdrc"] = "sxhkd",
    },
    pattern = {
        ["*.cjsn"] = "jsonc",
        ["*.cjson"] = "jsonc",
        [".*/zsh/functions/.*"] = "zsh",
    },
})
