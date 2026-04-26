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
