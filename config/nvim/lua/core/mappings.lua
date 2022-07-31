local utils = require("core.utils")
local map = utils.map
local nnoremap = utils.nnoremap
local tnoremap = utils.tnoremap
local vnoremap = utils.vnoremap
local no_silent = { silent = false }

-- No need to keep holding shift
nnoremap(";", ":", no_silent)
vnoremap(";", ":", no_silent)

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
nnoremap("<C-L>", ":bnext<CR>")
nnoremap("<C-H>", ":bprevious<CR>")
nnoremap("<C-w>", ":bdelete<CR>")

-- Don't put text in register on delete char
map({ "n", "v" }, "x", '"_x')

-- Keep visual mode indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Quick edit/source config files
nnoremap("<Leader>ev", ":edit $MYVIMRC<CR>", {
    desc = "Edit $MYVIMRC",
})
-- TODO: Make it hard reload init.lua
nnoremap("<Leader>sv", ":source $MYVIMRC<CR>", {
    desc = "Source $MYVIMRC",
})
nnoremap("<Leader>ed", ":edit $CONFIG_DIR/config<CR>", {
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
        -- FIXME: https://github.com/neovim/neovim/issues/18160
        -- require("core.utils").highlight("Tabs", { bg = "yellow" })
    end
end, {
    desc = "Toggle tab highlighting",
})

-- Quick find and replace (stolen from @akinsho)
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/
vnoremap(
    "<Leader>rr",
    [[<esc>:'<,'>s/]],
    { desc = "Within visually selected area", silent = false }
)
nnoremap("<Leader>rr", [[:%s/]], { desc = "Replace text", silent = false })
vnoremap(
    "<Leader>rw",
    [["zy:%s/<C-r><C-o>"/]],
    { desc = "Visually selected text", silent = false }
)
nnoremap(
    "<Leader>rw",
    [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
    { desc = "Replace word under cursor", silent = true }
)
