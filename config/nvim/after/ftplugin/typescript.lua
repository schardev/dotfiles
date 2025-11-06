-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

-- set compiler
local pkg_manager = require("core.utils").get_package_manager()
local tsc_cmd = "tsc"

-- use `tsgo` as makeprg if exists
if vim.fn.executable("tsgo") == 1 then
  tsc_cmd = "tsgo"
end

-- `:help compiler-tsc`
vim.b.tsc_makeprg = table.concat({ pkg_manager, tsc_cmd, "--noEmit" }, " ")
vim.cmd.compiler("tsc")

-- Surround
local installed, surround = pcall(require, "nvim-surround")

if not installed then
  return
end

local config = require("nvim-surround.config")

surround.buffer_setup({
  surrounds = {
    -- https://github.com/kylechui/nvim-surround/discussions/53
    ["g"] = {
      add = function()
        local result = config.get_input("Enter the generic name: ")
        if result then
          return { { result .. "<" }, { ">" } }
        end
      end,
      find = function()
        return config.get_selection({ node = "generic_type" })
      end,
      delete = "^(.-<)().-(>)()$",
      change = {
        target = "^(.-<)().-(>)()$",
        replacement = function()
          local result = config.get_input("Enter the generic name: ")
          if result then
            return { { result .. "<" }, { ">" } }
          end
        end,
      },
    },
  },
})
