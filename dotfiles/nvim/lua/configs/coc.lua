local map = require("core.utils").map
local inoremap = require("core.utils").inoremap
local nnoremap = require("core.utils").nnoremap
local vnoremap = require("core.utils").vnoremap
local autocmd = vim.api.nvim_create_autocmd
local configs_coc = vim.api.nvim_create_augroup("ConfigsCoc", { clear = true })

-- " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- " delays and poor user experience.
vim.opt.updatetime = 300

-- " Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- " Install these coc.nvim extensions by default
vim.g.coc_global_extensions = {
    "coc-clangd",
    "coc-css",
    "coc-docker",
    "coc-emmet",
    "coc-eslint",
    "coc-git",
    "coc-html",
    "coc-html-css-support",
    "coc-json",
    "coc-pyright",
    "coc-pairs",
    "coc-prettier",
    "coc-snippets",
    "coc-tsserver",
    "coc-vimlsp",
    "coc-yaml",
    "coc-yank",
}

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return not col or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

inoremap("<TAB>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    elseif vim.fn["coc#expandableOrJumpable"]() == 1 then
        return "<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>"
    else
        return "<TAB>"
    end
end, { expr = true })

inoremap("<S-TAB>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    elseif check_back_space() then
        return "<Tab>"
    else
        return vim.fn["coc#refresh"]()
    end
end, { expr = true })

-- " Use <TAB> and <S-TAB> to navigate snippets
vim.g.coc_snippet_next = "<TAB>"
vim.g.coc_snippet_prev = "<S-TAB>"

-- Make <CR> to notify coc.nvim to format on enter
inoremap("<CR>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-y>"
    else
        return "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
    end
end, { expr = true })

-- Select text for visual placeholder of snippet
vnoremap("<Leader>S", "<Plug>(coc-snippes-select)")

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap("[g", "<Plug>(coc-diagnostic-prev)")
nnoremap("]g", "<Plug>(coc-diagnostic-next)")

-- GoTo code navigation.
nnoremap("gd", "<Plug>(coc-definition)")
nnoremap("gy", "<Plug>(coc-type-definition)")
nnoremap("gi", "<Plug>(coc-implementation)")
nnoremap("gr", "<Plug>(coc-references)")

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)")
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)")
map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)")
map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)")

-- Symbol renaming.
nnoremap("<Leader>rn", "<Plug>(coc-rename)")

-- Use D to show documentation in preview window.
local show_documentation = function()
    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
        vim.fn.execute("h " .. vim.fn.expand("<cword>"))
    elseif vim.fn["coc#rpc#ready"]() == 1 then
        vim.fn["CocActionAsync"]("doHover")
    else
        vim.fn.execute(
            "!" .. vim.bo.keywordprg .. " " .. vim.fn.expand("<cword>")
        )
    end
end
nnoremap("D", show_documentation)

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
map({ "x", "n" }, "<Leader>a", "<Plug>(coc-codeaction-selected)")

-- Formatting selected code.
map({ "x" }, "<Leader>f", "<Plug>(coc-format-selected)")

-- Remap keys for applying codeAction to the current buffer.
nnoremap("<Leader>ac", "<Plug>(coc-codeaction)")

-- Apply AutoFix to problem on the current line.
nnoremap("<Leader>qf", "<Plug>(coc-fix-current)")

-- Multicursor
local select_current_word = function()
    if vim.b.coc_cursors_activated == 1 then
        return "*<Plug>(coc-cursors-word):nohlsearch<CR>"
    end
    return "<Plug>(coc-cursors-word)"
end
nnoremap("<C-d>", select_current_word, { expr = true })

autocmd("FileType", {
    group = configs_coc,
    pattern = { "typescript", "json" },
    command = "setl formatexpr=CocAction('formatSelected')",
})

autocmd("User", {
    group = configs_coc,
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
})

autocmd("CursorHold", {
    group = configs_coc,
    pattern = "*",
    command = "call CocActionAsync('highlight')",
})

-- Remap <C-f> and <C-b> for scroll float windows/popups.
if vim.fn.has("nvim-0.4.0") or vim.fn.has("patch-8.2.0750") then
    map(
        { "n", "v" },
        "<C-f>",
        [[coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"]],
        { expr = true, nowait = true }
    )
    map(
        { "n", "v" },
        "<C-b>",
        [[coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"]],
        { expr = true, nowait = true }
    )
    inoremap(
        "<C-f>",
        [[coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<CR>" : "<Right>"]],
        { expr = true, nowait = true }
    )
    inoremap(
        "<C-f>",
        [[coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<CR>" : "<Left>"]],
        { expr = true, nowait = true }
    )
end

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
map({ "n", "x" }, "<C-s>", "<Plug>(coc-range-select)")

-- CocList Commands
nnoremap(
    "<space>e",
    ":<C-u>CocList extensions<cr>",
    { desc = "Coc extensions" }
)

nnoremap("<space>c", ":<C-u>CocList commands<cr>", { desc = "Coc commands" })

-- Open yank list
nnoremap("<space>y", ":<C-u>CocList yank<cr>", { desc = "Yank List" })

-- Show all diagnostics.
nnoremap(
    "<space>d",
    ":<C-u>CocList diagnostics<cr>",
    { desc = "Coc diagnostics" }
)
-- Do default action for next item.
-- nnoremap("<space>j", ":<C-u>CocNext<CR>")

-- Do default action for previous item.
-- nnoremap("<space>k", ":<C-u>CocPrev<CR>")

-- Resume latest coc list.
-- nnoremap("<space>p", ":<C-u>CocListResume<CR>")
