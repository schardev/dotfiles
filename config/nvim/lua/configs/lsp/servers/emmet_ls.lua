local M = {
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

    -- FIXME: These options doesn't seem to work
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts
                ["bem.enabled"] = true,
                ["bem.modifier"] = "--",
            },
        },
        javascriptreact = {
            options = {
                ["jsx.enabled"] = true,
            },
        },
    },
}

return M
