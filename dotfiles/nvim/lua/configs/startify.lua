local autocmd = vim.api.nvim_create_autocmd
local g = vim.g

-- Center startify header
g.startify_custom_header = "startify#center(startify#fortune#cowsay())"

-- Bookmark $MYVIMRC on startify for quick edit
g.startify_bookmarks = { { v = "$MYVIMRC" }, { d = "~/env/dotfiles" } }

g.startify_commands = {
    { ch = { "Check Health", ":checkhealth" } },
    { pc = { "Packer Clean", ":PackerClean" } },
    { ps = { "Packer Status", "PackerStatus" } },
    { pi = { "Packer Sync", ":PackerSync" } },
    { pu = { "Packer Update", "PackerUpdate" } },
}

-- Open startify when there's no buffer left
-- https://github.com/mhinz/vim-startify/issues/424#issuecomment-704865423
local configs_startify = vim.api.nvim_create_augroup("ConfigsStartify", {
    clear = true,
})

autocmd("BufDelete", {
    group = configs_startify,
    pattern = "*",
    callback = function()
        if
            vim.fn.empty(
                vim.fn.filter(vim.fn.tabpagebuflist(), "!buflisted(v:val)")
            ) > 0
        then
            vim.cmd("Startify")
        end
    end,
    desc = "Show startify screen if no buffers left to display",
})
