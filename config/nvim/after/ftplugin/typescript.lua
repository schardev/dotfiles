-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

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
