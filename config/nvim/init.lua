-- SPDX-License-Identifier: MIT
-- Copyright (C) 2020-2022 Saurabh Charde <saurabhchardereal@gmail.com>

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = {
  defaults = {
    --lazy = true
  },
  dev = {
    path = "~/workspace",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "man",
        "matchit",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "tar",
        "tarPlugin",
        "tutor",
        "tutor_mode_plugin",
        "vimball",
        "zip",
        "zipPlugin",
      },
    },
  },
}

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

-- Load modules/plugins
require("core")
require("lazy").setup("plugins", lazy_config)

-- local installed, impatient = pcall(require, "impatient")
--
-- if not installed then
--   vim.notify("Impatient not installed!")
-- else
--   impatient.enable_profile()
-- end
