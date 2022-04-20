-- SPDX-License-Identifier: MIT
--
-- Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>

-- Opt-in for lua filetype detection
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Load modules
require("core")
require("colors")

-- Main plugin loading is done via `packer_compiled.lua`
-- so no need to load this immediately
vim.defer_fn(function()
    require("plugins")
end, 0)

-- Disable neovim providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
