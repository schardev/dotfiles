vim.filetype.add({
    filename = {
        [".eslintrc.json"] = "jsonc",
        ["coc-settings.json"] = "jsonc",
        ["keybindings.json"] = "jsonc",
        ["tsconfig.json"] = "jsonc",
    },
    pattern = {
        ["*.cjsn"] = "jsonc",
        ["*.cjson"] = "jsonc",
    },
})
