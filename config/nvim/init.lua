-- SPDX-License-Identifier: MIT
--
-- Copyright (C) 2020-2021 Saurabh Charde <saurabhchardereal@gmail.com>

local installed, impatient = pcall(require, "impatient")

if not installed then
    vim.notify("Impatient not installed!")
else
    impatient.enable_profile()
end

-- Disable neovim providers
local disabled_provider = {
    "node",
    "perl",
    "python",
    "python3",
    "pythonx",
    "ruby",
}

for _, d in pairs(disabled_provider) do
    vim.g["loaded_" .. d .. "_provider"] = 0
end

-- Disable few unused builtin plugins
local disabled_plugin = {
    "2html_plugin",
    "gzip",
    "man",
    "matchit",
    "netrw",
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "tar",
    "tarPlugin",
    "tutor_mode_plugin",
    "vimball",
    "zip",
    "zipPlugin",
}

for _, d in pairs(disabled_plugin) do
    vim.g["loaded_" .. d] = 1
end

--- Load modules
require("core")
