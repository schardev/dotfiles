local g = vim.g

-- Default list of ALE 'linters' for respective file-type
g.ale_linters = {
    c = { "clangtidy" },
    cpp = { "clangtidy" },
    javascript = {},
    sh = { "shellcheck" },
}

-- Only trigger linters from `g:ale_linters` list
-- NOTE: ALE will enable as many linters as possible by default
g.ale_linters_explicit = 1

-- Default list of ALE 'fixers' for respective file-type
g.ale_fixers = {
    ["*"] = { "remove_trailing_lines", "trim_whitespace" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    sh = { "shfmt" },
}

-- Fix all files on save, excluding few specfic
g.ale_fix_on_save = 1
g.ale_fix_on_save_ignore = {
    c = { "clang-format" },
    cpp = { "clang-format" },
}

-- Use better error/warning signs
g.ale_sign_error = ""
g.ale_sign_warning = ""
g.ale_sign_info = ""

-- Mapping to quickly fix
-- nnoremap <silent> <Leader>f :ALEFix<CR>

-- Disable ALE provided LSP features (we are using coc.nvim)
g.ale_disable_lsp = 1

-- shfmt extra options
-- `-ci`  -- format case statements
-- `-i 4` -- indents will have width of 4 spaces
g.ale_sh_shfmt_options = "-ci -i 4"

-- shellcheck extra options
-- SC1090 -- Can't follow non-constant source. Use a directive to specify location
-- SC1091 -- Almost the same reason as above
g.ale_sh_shellcheck_options = "-s bash -e SC1090,SC1091"

-- Set `-style=Google`
g.ale_c_clangformat_style_option = "Google"

-- Enable below option to use local .clang-format file
-- let g:ale_c_clangformat_use_local_file = 1

-- Stylua
g.ale_lua_stylua_options = "--config-path ~/.config/nvim/.stylua.toml"
