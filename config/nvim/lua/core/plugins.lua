local env = require("core.env")
if env.NVIM_USER_ONLY_CORE then
  return
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local lazy_config = {
  defaults = {
    --lazy = true
  },
  dev = {
    path = "~/dev",
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "matchit",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "tar",
        "tarPlugin",
        "tutor",
        "tutor_mode_plugin",
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

require("lazy").setup("plugins", lazy_config)
