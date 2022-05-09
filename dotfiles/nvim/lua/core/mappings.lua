local utils = require("core.utils")

local nnoremap = utils.nnoremap
local tnoremap = utils.tnoremap
local vnoremap = utils.vnoremap

-- No need to keep holding shift
nnoremap(";", ":", { silent = false })
vnoremap(";", ":", { silent = false })

-- Map H and L to start and end of the line respectively (makes more sence that way)
nnoremap("H", "0")
nnoremap("L", "$")

-- Navigating between windows
nnoremap("<C-Up>", ":wincmd k<CR>")
nnoremap("<C-Down>", ":wincmd j<CR>")
nnoremap("<C-Left>", ":wincmd h<CR>")
nnoremap("<C-Right>", ":wincmd l<CR>")

-- Moving windows
nnoremap("<C-S-Up>", ":wincmd K<CR>")
nnoremap("<C-S-Down>", ":wincmd J<CR>")
nnoremap("<C-S-Left>", ":wincmd H<CR>")
nnoremap("<C-S-Right>", ":wincmd L<CR>")

-- Resizing windows
nnoremap("<M-Up>", ":resize +2<CR>")
nnoremap("<M-Down>", ":resize -2<CR>")
nnoremap("<M-Left>", ":vertical resize +2<CR>")
nnoremap("<M-Right>", ":vertical resize -2<CR>")

-- Quick moving around while keeping the cursor fixed in middle
nnoremap("J", "5jzz")
nnoremap("K", "5kzz")

-- Buffer management
nnoremap("<Leader>n", ":bnext<CR>")
nnoremap("<Leader>p", ":bprevious<CR>")
nnoremap("<C-w>", ":bdelete<CR>")

-- Quick edit/source config files
nnoremap("<Leader>ev", ":edit $MYVIMRC<CR>", {
    desc = "Edit $MYVIMRC",
})
nnoremap("<Leader>sv", ":source $MYVIMRC<CR>", {
    desc = "Source $MYVIMRC",
})
nnoremap("<Leader>es", ":CocConfig<CR>", {
    desc = "Edit global coc-settings.json",
})
nnoremap("<Leader>ed", ":edit ~/env/dotfiles<CR>", {
    desc = "Edit dotfiles",
})
nnoremap("<Leader>se", utils.save_and_exec, {
    desc = "Save and execute vim/lua files",
})

-- Make <Esc> to actually escape from terminal mode
tnoremap("<Esc>", "<C-\\><C-n>")

-- Toggle highlights
nnoremap("<Leader>sh", ":set hlsearch!<CR>", {
    desc = "Toggle search highlighting",
})
nnoremap("<Leader>th", function()
    if vim.g.tab_highlight == 1 then
        vim.cmd("highlight clear Tabs")
        vim.g.tab_highlight = 0
    else
        vim.g.tab_highlight = 1
        vim.cmd("highlight Tabs guibg=yellow")
        -- https://github.com/neovim/neovim/issues/18160
        -- require("core.utils").highlight("Tabs", { bg = "yellow" })
    end
end, {
    desc = "Toggle tab highlighting",
})
