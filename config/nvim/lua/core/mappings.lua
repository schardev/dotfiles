local utils = require("core.utils")
local mapper = utils.mapper_factory
local nnoremap = mapper("n")
local tnoremap = mapper("t")
local vnoremap = mapper("v")
local xnoremap = mapper("x")
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
mapper({ "n", "v" })("x", '"_x')

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

-- Few mappings I stolen from @akinsho :)
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/

-- Quick find and replace
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

-- Search visual selection
vnoremap("//", [[y/<C-R>"<CR>]])

-- Multiple Cursor Replacement
---@see http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-- 1. Position the cursor over a word; alternatively, make a selection.
-- 2. Hit cq to start recording the macro.
-- 3. Once you are done with the macro, go back to normal mode.
-- 4. Hit Enter to repeat the macro over search matches.
function Setup_CR()
    nnoremap(
        "<Enter>",
        [[:nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z]]
    )
end
vim.g.mc = [[y/\V<C-r>=escape(@", '/')<CR><CR>]]

nnoremap("cn", "*``cgn")
nnoremap("cN", "*``cgN")

vnoremap("cn", [[g:mc . "``cgn"]], { expr = true })
vnoremap("cN", [[g:mc . "``cgN"]], { expr = true })

nnoremap("cq", [[:\<C-u>call v:lua.Setup_CR()<CR>*``qz]])
nnoremap("cQ", [[:\<C-u>call v:lua.Setup_CR()<CR>#``qz]])

vnoremap(
    "cq",
    [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . g:mc . "``qz"]],
    { expr = true }
)
vnoremap(
    "cQ",
    [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . substitute(g:mc, '/', '?', 'g') . "``qz"]],
    { expr = true }
)

-- Replicate netrw functionality (gx/gf)
local function open(path)
    vim.fn.jobstart({ "xdg-open", path }, { detach = true })
    vim.notify(string.format("Opening %s", path))
end

local function open_link()
    local file = vim.fn.expand("<cfile>")
    if vim.fn.isdirectory(file) > 0 then
        return vim.cmd("edit " .. file)
    end

    if file:match("https://") then
        return open(file)
    end

    -- consider anything that looks like string/string a github link
    local plugin_url_regex = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
    local link = string.match(file, plugin_url_regex)
    if link then
        return open(string.format("https://www.github.com/%s", link))
    end
end

nnoremap("gx", open_link)
nnoremap("gf", "<Cmd>e <cfile><CR>")

-- greatest remap ever (courtesy of @theprimeagen)
xnoremap("<Leader>p", '"_dP')
