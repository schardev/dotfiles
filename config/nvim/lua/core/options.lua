local set = vim.o
local opt = vim.opt
local cmd = vim.cmd
local CONFIG_DIR = require("core.env").NVIM_USER_CONFIG_DIR

-- stylua: ignore start
cmd('filetype plugin indent on ')       -- Used for indentation based on file-type
cmd('syntax enable')                    -- Enable syntax highlighting
set.backup = false                      -- Disable backup
set.breakindent = true                  -- Preserve indentation while wrapping
set.cmdheight = 2                       -- Set command panel height
set.colorcolumn = "80"                  -- Highlight 80th column
set.cursorline = true                   -- Highlight current line number
set.encoding = "utf-8"                  -- It's the default in nvim but vim sets it conditionally
opt.fillchars = {vert = '│', eob = '~'} -- Set vertical and empty lines chars
set.foldlevel = 99                      -- Fold after this level (hax to prevent folding by default)
set.hidden = true                       -- Allow buffers to be hidden
set.hlsearch = false                    -- Disable search highlighting
set.ignorecase = true                   -- Ignore case for pattern matching by default
set.incsearch = true                    -- Incrementally highlights search patterns
set.laststatus = 3                      -- Enable global statusline
set.lazyredraw = true                   -- Don't redrawn while executing macros
set.mouse = "n"                         -- Enable mouse support in normal only
set.number = true                       -- Show line numbers
set.numberwidth = 2                     -- Minimal number of columns to use for the line number
set.relativenumber = true               -- Shows line number relative to the current line
set.scrolloff = 5                       -- Scroll offset
set.shell = "bash"                      -- Set default shell to bash coz zsh isn't POSIX-compatible
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
set.termguicolors = true                -- Term supports gui colors
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
