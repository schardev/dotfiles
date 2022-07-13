local null_ls = require("null-ls")
local on_attach = require("configs.lsp.events").on_attach
local utils = require("null-ls.utils")
local helpers = require("null-ls.helpers")

local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

-- Filetypes to trim whitespace and newlines
local trim_filetypes = {
    "dosini",
    "text",
    "toml",
    "vim",
    "zsh",
}

-- Enable specific formatters only if the root has config file
local eslint_runtime_condition = helpers.cache.by_bufnr(function(params)
    local config_path = utils.root_pattern(
        -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json"
        -- "package.json"
    )(params.bufname)
    return config_path ~= nil
end)

local stylua_runtime_condition = helpers.cache.by_bufnr(function(params)
    local config_path =
        utils.root_pattern(".stylua.toml", "stylua.toml")(params.bufname)
    return config_path ~= nil
end)

local sources = {
    --------------------------------
    ---       CODE ACTIONS       ---
    --------------------------------

    actions.gitsigns.with({
        condition = function(util)
            return util.root_has_file({ ".git" })
        end,
    }),

    actions.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
    }),

    actions.shellcheck,

    --------------------------------
    ---       DIAGNOSTICS       ---
    --------------------------------

    diagnostics.shellcheck.with({
        diagnostics_format = "[SC#{c}] #{m}",
        extra_args = {
            "-s",
            "bash",
            "-e", -- Start ignoring below rules:
            -- "SC1090" - Can't follow non-constant source. Use a directive to specify location
            -- "SC1091" - Almost the same reason as above
            "SC1090,SC1091",
        },
    }),

    diagnostics.eslint_d.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE, -- run eslint on save
        runtime_condition = eslint_runtime_condition,
    }),

    ------------------------------
    ---       FORMATTING       ---
    ------------------------------

    formatting.prettierd,
    formatting.eslint_d.with({
        runtime_condition = eslint_runtime_condition,
    }),

    formatting.stylua.with({
        -- cwd = function(params)
        -- utils.spawn_with_lsp_root(params, "sumneko_lua")
        -- end,
        runtime_condition = stylua_runtime_condition,
    }),

    formatting.trim_newlines.with({
        filetypes = trim_filetypes,
    }),

    formatting.trim_whitespace.with({
        filetypes = trim_filetypes,
    }),

    formatting.shfmt.with({
        extra_args = {
            "-ci", -- format case statements
            "-i",
            "4", -- indents will have width of 4 spaces
        },
    }),
}

null_ls.setup({
    on_attach = on_attach,
    debounce = vim.o.updatetime, -- Bind debounce with global option
    debug = false, -- View logs with `:NullLsLog` after setting to true
    diagnostics_format = "[#{c}] #{m}",
    sources = sources,
})
