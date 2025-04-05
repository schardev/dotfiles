local utils = require("core.utils")
local map = utils.map

-- No need to keep holding shift
map({ "n", "v" }, ";", ":", { silent = false })
map("n", "<Leader>;", ";", "Next f/t match")

-- Map H and L to start and end of the line respectively (makes more sence that way)
-- map("n", "H", "0")
-- map("n", "L", "$")

-- Join lines without losing cursor position
map("n", "J", "mjJ`j")

-- Navigating between windows
map("n", "<C-Up>", function()
  utils.navigate_pane_or_window("k")
end)
map("n", "<C-Down>", function()
  utils.navigate_pane_or_window("j")
end)
map("n", "<C-Left>", function()
  utils.navigate_pane_or_window("h")
end)
map("n", "<C-Right>", function()
  utils.navigate_pane_or_window("l")
end)

-- Moving windows
map("n", "<C-S-Up>", ":wincmd K<CR>")
map("n", "<C-S-Down>", ":wincmd J<CR>")
map("n", "<C-S-Left>", ":wincmd H<CR>")
map("n", "<C-S-Right>", ":wincmd L<CR>")

-- Resizing windows
map("n", "<M-Up>", ":resize +2<CR>")
map("n", "<M-Down>", ":resize -2<CR>")
map("n", "<M-Left>", ":vertical resize +2<CR>")
map("n", "<M-Right>", ":vertical resize -2<CR>")

-- Quick moving around while keeping the cursor fixed in middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Buffer management
map("n", "<C-L>", ":bnext<CR>")
map("n", "<C-H>", ":bprevious<CR>")
map("n", "<Leader>qw", ":bdelete<CR>")

-- Toggle wrap
map("n", "<Leader>w", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("Wrap " .. (vim.o.wrap and "on" or "off"), vim.log.levels.INFO)
end, "Toggle wrap")

-- Don't put text in register on delete char
map({ "n", "v" }, "x", '"_x')

-- Copy to system clipboard
map({ "x", "n" }, "<Leader>y", [["+y]], "Yank to system clipboard")

-- Replicate netrw functionality (gx/gf)
map("n", "gx", utils.open, "Open link or file")

-- Keep visual mode indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Select all lines
map("n", "vga", "ggVG")

-- Quick source/run files
map("n", "<Leader><Leader>x", ":source %<CR>", "Source current file")
map("n", "<Leader>x", ":.lua<CR>", "Run current line with lua")
map("v", "<Leader>x", ":lua<CR>", "Run visual selection with lua")

-- Diagnostics
map("n", "<Leader>td", function()
  local is_enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not is_enabled)
  vim.notify(
    "[LSP] " .. (is_enabled and "Disabled" or "Enabled") .. " diagnostics."
  )
end, "Toggle diagnostics")

-- Make <Esc> to actually escape from terminal mode
map("t", "<Esc>", "<C-\\><C-n>")

-- `dd` but don't yank if the line is empty
map("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return [["_dd]]
  else
    return [[dd]]
  end
end, { expr = true })

-- Toggle highlights
map("n", "<Leader>ts", ":set hlsearch!<CR>", "Toggle search highlighting")
map("n", "<Leader>tw", function()
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
end, "Toggle whitespace highlighting")

--- Few mappings I stole from @akinsho :)
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/

-- Quick find and replace
map(
  "v",
  "<Leader>rr",
  [[<esc>:'<,'>s//<left>]],
  { desc = "Within visually selected area", silent = false }
)
map(
  "n",
  "<Leader>rr",
  [[:%s//<left>]],
  { desc = "Replace text", silent = false }
)
map(
  "v",
  "<Leader>rw",
  [["zy:%s/<C-r><C-o>"/]],
  { desc = "Visually selected text", silent = false }
)
map(
  "n",
  "<Leader>rw",
  [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
  { desc = "Replace word under cursor", silent = false }
)

-- Search visual selection
-- map("v", "//", [[y/<C-R>"<CR>]])

-- Multiple Cursor Replacement
---@see http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-- 1. Position the cursor over a word; alternatively, make a selection.
-- 2. Hit cq to start recording the macro.
-- 3. Once you are done with the macro, go back to normal mode.
-- 4. Hit Enter to repeat the macro over search matches.
function Setup_CR()
  map(
    "n",
    "<Enter>",
    [[:nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z]],
    { buffer = true }
  )
end
vim.g.mc = [[y/\V<C-r>=escape(@", '/')<CR><CR>]]

map("n", "cn", "*``cgn")
map("n", "cN", "*``cgN")

-- xnoremap("cn", [[g:mc . "``cgn"]], { expr = true })
-- xnoremap("cN", [[g:mc . "``cgN"]], { expr = true })

map("n", "cq", [[:\<C-u>call v:lua.Setup_CR()<CR>*``qz]])
map("n", "cQ", [[:\<C-u>call v:lua.Setup_CR()<CR>#``qz]])

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
