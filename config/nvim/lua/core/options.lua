local set = vim.opt
local cmd = vim.cmd

-- stylua: ignore start
cmd('filetype plugin indent on ')       -- Used for indentation based on file-type
cmd('syntax enable')                    -- Enable syntax highlighting
set.backup = false                      -- Disable backup
set.cmdheight = 2                       -- Set command panel height
set.colorcolumn = "80"                  -- Highlight 80th column
set.cursorline = true                   -- Highlight current line number
set.encoding = "utf-8"                  -- It's the default in nvim but vim sets it conditionally
set.expandtab = true                    -- Expand TABs to spaces
set.fillchars:append("vert:│,eob:~")    -- Set vertical and empty lines chars
set.foldlevel = 99                      -- Fold after this level (hax to prevent folding by default)
set.hidden = true                       -- Allow buffers to be hidden
set.ignorecase = true                   -- Ignore case for pattern matching by default
set.incsearch = true                    -- Incrementally highlights search patterns
set.laststatus = 3                      -- Enable global statusline
set.lazyredraw = true                   -- Don't redrawn while executing macros
set.mouse = "ni"                        -- Enable mouse support in normal and insert mode
set.number = true                       -- Show line numbers
set.numberwidth = 2                     -- Minimal number of columns to use for the line number
set.relativenumber = true               -- Shows line number relative to the current line
set.scrolloff = 3                       -- Scroll offset
set.shell = "bash"                      -- Set default shell to bash coz zsh isn't POSIX-compatible
set.shiftwidth = 4                      -- Indents will have a width of 4
set.smartcase = true                    -- Override `ignorecase` where possible
set.softtabstop = 4                     -- Sets the number of columns for a TAB
set.synmaxcol = 190                     -- Don't even try to highlight stuff that's longer than 190 columns
set.wildignore:append({                 -- Ignore these directories/files while expanding `find` searches
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
set.tabstop = 4                         -- The width of a TAB is set to 4.
                                        -- Still it is a \t. It is just that
                                        -- vim will interpret it to be having
                                        -- a width of 4.
set.termguicolors = true                -- Term supports gui colors
set.title = true                        -- Set window title appropriately
set.pumblend=15                         -- Enable a subtle transparency effect on pop-up menu
set.signcolumn="yes:2"                  -- Reserve space for atleast two signs
set.undofile = true                     -- Enable undo file
vim.g.mapleader = ","                   -- Set global <Leader> to `,`
vim.g.maplocalleader = " "              -- Set <LocalLeader>
vim.g.markdown_fenced_languages = {     -- Filemap for markdown code blocks
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}
-- stylua: ignore end
