local nnoremap = require("core.utils").nnoremap
local builtin = require("telescope.builtin")

-- Mappings
nnoremap("<Leader>sf", builtin.find_files, { desc = "Find Files" })
nnoremap(
    "<Leader>sb",
    builtin.current_buffer_fuzzy_find,
    { desc = "Live fuzzy search inside current buffer" }
)
nnoremap("<Leader>sg", builtin.live_grep, { desc = "Live Grep" })
nnoremap("<Leader>st", builtin.help_tags, { desc = "Helptags" })
nnoremap("<Leader>ss", builtin.builtin, { desc = "Telescope Builtins" })
nnoremap("<Leader>sr", builtin.oldfiles, { desc = "Oldfiles" })

-- Load native fzf sorter
require("telescope").load_extension("fzf")
