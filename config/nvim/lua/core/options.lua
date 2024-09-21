local set = vim.o
local opt = vim.opt
local CONFIG_DIR = require("core.env").NVIM_USER_CONFIG_DIR

-- stylua: ignore start
set.backup = false                      -- Disable backup
set.breakindent = true                  -- Preserve indentation while wrapping
set.cmdheight = 2                       -- Set command panel height
set.colorcolumn = "80"                  -- Highlight 80th column
set.cursorline = true                   -- Highlight current line number
set.hlsearch = false                    -- Disable search highlighting
set.ignorecase = true                   -- Ignore case for pattern matching by default
set.laststatus = 3                      -- Enable global statusline
set.lazyredraw = true                   -- Don't redrawn while executing macros
set.number = true                       -- Show line numbers
set.numberwidth = 2                     -- Minimal number of columns to use for the line number
set.relativenumber = true               -- Shows line number relative to the current line
set.scrolloff = 5                       -- Scroll offset
set.spellfile = CONFIG_DIR .. '/nvim/spell/en.utf-8.add'
set.splitright = true                   -- Splits windows to the right by default
set.smartcase = true                    -- Override `ignorecase` where possible
set.synmaxcol = 190                     -- Don't even try to highlight stuff that's longer than 190 columns
opt.wildignore:append({                 -- Ignore these directories/files while expanding `find` searches
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
set.wildignorecase = true               -- Ignore case while completing file
set.wrap = false                        -- Do not wrap code by default
set.writebackup = false                 -- Disable backup
set.title = true                        -- Set window title appropriately
set.pumblend=15                         -- Enable a subtle transparency effect on pop-up menu
set.signcolumn="yes:2"                  -- Reserve space for atleast two signs
set.undofile = true                     -- Enable undo file
vim.g.mapleader = " "                   -- Set global <Leader> to `,`
vim.g.maplocalleader = ","              -- Set <LocalLeader>
-- stylua: ignore end

-- Indentation
set.expandtab = true -- Expand <Tab> to spaces
set.shiftwidth = 2 -- Indents (`>>`, `<<`, etc) inserts this much width
set.softtabstop = 2 -- Sets the number of columns for a <Tab>
set.tabstop = 2 -- The width of <Tab>
