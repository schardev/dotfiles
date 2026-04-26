vim.opt_local.iskeyword:append({ "'" })

-- There should be no restriction for 80-char limit in markdown files, so wrap
-- them but don't break words (easier to read that way)
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = ""
vim.opt_local.spell = true
