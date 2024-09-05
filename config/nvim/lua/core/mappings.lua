local utils = require("core.utils")
local mapper = utils.mapper_factory
local nnoremap = mapper("n")
local tnoremap = mapper("t")
local vnoremap = mapper("v")

-- No need to keep holding shift
nnoremap(";", ":", { silent = false })
vnoremap(";", ":", { silent = false })

-- Map H and L to start and end of the line respectively (makes more sence that way)
nnoremap("H", "0")
nnoremap("L", "$")

-- Navigating between windows
nnoremap("<C-Up>", function()
  utils.navigate_pane_or_window("k")
end)
nnoremap("<C-Down>", function()
  utils.navigate_pane_or_window("j")
end)
nnoremap("<C-Left>", function()
  utils.navigate_pane_or_window("h")
end)
nnoremap("<C-Right>", function()
  utils.navigate_pane_or_window("l")
end)

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
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Quickfix list
nnoremap("]q", ":cnext<CR>", { desc = "Quickfix next" })
nnoremap("[q", ":cprev<CR>", { desc = "Quickfix prev" })

-- Location list
nnoremap("]l", ":lnext<CR>", { desc = "Loclist next" })
nnoremap("[l", ":lprev<CR>", { desc = "Loclist prev" })

-- Remap for dealing with word wrap
nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer management
nnoremap("<C-L>", ":bnext<CR>")
nnoremap("<C-H>", ":bprevious<CR>")
nnoremap("<Leader>qw", ":bdelete<CR>")

-- Toggle wrap
nnoremap("<Leader>w", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("Wrap " .. (vim.o.wrap and "on" or "off"), vim.log.levels.INFO)
end, { desc = "Toggle wrap" })

-- Don't put text in register on delete char
mapper({ "n", "v" })("x", '"_x')

-- Copy to system clipboard
mapper({ "x", "n" })("<Leader>y", [["+y]])

-- Replicate netrw functionality (gx/gf)
nnoremap("gx", utils.open)

-- Keep visual mode indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Select all lines
nnoremap("vga", "ggVG")

-- Quick edit/source config files
nnoremap("<Leader>ev", ":edit $MYVIMRC<CR>", {
  desc = "Edit $MYVIMRC",
})
nnoremap("<Leader>se", utils.save_and_exec, {
  desc = "Save and execute vim/lua files",
})

-- Diagnostics
nnoremap("]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
nnoremap("[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
nnoremap("<Leader>td", function()
  local is_enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not is_enabled)
  vim.notify(
    "[LSP] " .. (is_enabled and "Disabled" or "Enabled") .. " diagnostics."
  )
end, { desc = "Toggle diagnostics" })

-- Make <Esc> to actually escape from terminal mode
tnoremap("<Esc>", "<C-\\><C-n>")

-- `dd` but don't yank if the line is empty
nnoremap("dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return [["_dd]]
  else
    return [[dd]]
  end
end, { expr = true })

-- Toggle highlights
nnoremap("<Leader>ts", ":set hlsearch!<CR>", {
  desc = "Toggle search highlighting",
})
nnoremap("<Leader>tw", function()
  if vim.w.whitespace_highlight == true then
    vim.cmd("highlight clear Tabs")
    vim.cmd("highlight clear ExtraWhitespace")
    vim.notify("Disabled whitespace highlighting!")
  else
    vim.cmd([[ highlight Tabs ctermbg=yellow guibg=yellow ]])
    vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
    vim.notify("Enabled whitespace highlighting!")
  end
  vim.w.whitespace_highlight = not vim.w.whitespace_highlight
end, {
  desc = "Toggle whitespace highlighting",
})

--- Few mappings I stole from @akinsho :)
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/

-- Quick find and replace
vnoremap(
  "<Leader>rr",
  [[<esc>:'<,'>s//<left>]],
  { desc = "Within visually selected area", silent = false }
)
nnoremap(
  "<Leader>rr",
  [[:%s//<left>]],
  { desc = "Replace text", silent = false }
)
vnoremap(
  "<Leader>rw",
  [["zy:%s/<C-r><C-o>"/]],
  { desc = "Visually selected text", silent = false }
)
nnoremap(
  "<Leader>rw",
  [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
  { desc = "Replace word under cursor", silent = false }
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
    [[:nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z]],
    { buffer = true }
  )
end
vim.g.mc = [[y/\V<C-r>=escape(@", '/')<CR><CR>]]

nnoremap("cn", "*``cgn")
nnoremap("cN", "*``cgN")

-- xnoremap("cn", [[g:mc . "``cgn"]], { expr = true })
-- xnoremap("cN", [[g:mc . "``cgN"]], { expr = true })

nnoremap("cq", [[:\<C-u>call v:lua.Setup_CR()<CR>*``qz]])
nnoremap("cQ", [[:\<C-u>call v:lua.Setup_CR()<CR>#``qz]])

-- xnoremap(
--   "cq",
--   [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . g:mc . "``qz"]],
--   { expr = true }
-- )
-- xnoremap(
--   "cQ",
--   [[":\<C-u>call v:lua.Setup_CR()<CR>gv" . substitute(g:mc, '/', '?', 'g') . "``qz"]],
--   { expr = true }
-- )
