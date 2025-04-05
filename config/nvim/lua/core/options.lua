local set = vim.o
local opt = vim.opt

-- Disable backup
set.writebackup = false
set.backup = false

-- Preserve indentation while wrapping
set.breakindent = true

-- Set command panel height
set.cmdheight = 2

-- Highlight column and current line number
set.colorcolumn = "80"
set.cursorline = true

-- Disable search highlighting
set.hlsearch = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set.ignorecase = true
set.smartcase = true

-- Enable global statusline
set.laststatus = 3

-- Don't redrawn while executing macros
set.lazyredraw = true

-- Show relative line numbers
set.number = true
set.numberwidth = 2
set.relativenumber = true

-- Don't show the mode, since it's already in the status line
set.showmode = false

-- Scroll offset
set.scrolloff = 5
set.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Splits windows to the right by default
set.splitright = true

-- Don't highlight stuff that's longer than 200 columns
set.synmaxcol = 200

-- Ignore these directories/files while expanding `find` searches
opt.wildignore:append({
  "*.o",
  "*.pyc",
  "*/.git/*",
  "*/node_modules/*",
  "*pycache*",
  "*~",
  "*.gif",
  "*.avi",
  "*.ico",
  "*.jpeg",
  "*.jpg",
  "*.png",
  "*.wav",
})

-- Ignore case while completing file
set.wildignorecase = true

-- Add rounded borders to floating windows by default
-- set.winborder = "rounded"

-- Do not wrap code by default
set.wrap = false

-- Set window title appropriately
set.title = true

-- Enable a subtle transparency effect on pop-up menu
set.pumblend = 15

-- Reserve space for atleast two signs
set.signcolumn = "yes:2"

-- Enable undo file
set.undofile = true

-- Set <Leader>
vim.g.mapleader = " "

-- Set <LocalLeader>
vim.g.maplocalleader = ","

-- Indentation
set.expandtab = true -- Expand <Tab> to spaces
set.shiftwidth = 2 -- Indents (`>>`, `<<`, etc) inserts this much width
set.softtabstop = 2 -- Sets the number of columns for a <Tab>
set.tabstop = 2 -- The width of <Tab>
