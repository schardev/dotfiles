vim.opt_local.spell = true
vim.opt_local.spelloptions:append("camel")
vim.opt_local.spellcapcheck = ""

vim.keymap.set("n", "<Leader>no", function()
  vim.cmd("botright terminal node")
  vim.cmd("wincmd J | startinsert")
end, { desc = "Open node repl in a termial split below" })

-- Surround
local installed, surround = pcall(require, "nvim-surround")

if not installed then
  return
end

surround.buffer_setup({
  surrounds = {
    ["s"] = {
      add = function()
        local ts_utils = require("nvim-treesitter.ts_utils")
        local cur = ts_utils.get_node_at_cursor(0, true)

        if not cur then
          return
        end

        local cur_type = cur:type()
        local interpolation_surround = { { "${" }, { "}" } }
        if cur and (cur_type == "string" or cur_type == "string_fragment") then
          vim.cmd.normal("csq`")
          return interpolation_surround
        elseif cur and cur_type == "template_string" then
          return interpolation_surround
        else
          return { { "`${" }, { "}`" } }
        end
      end,
    },
  },
})
