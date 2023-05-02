local installed, surround = pcall(require, "nvim-surround")

if installed then
  surround.buffer_setup({
    surrounds = {
      -- https://github.com/kylechui/nvim-surround/discussions/53
      ["l"] = {
        add = function()
          local clipboard = vim.fn.getreg("+"):gsub("\n", "")
          return {
            { "[" },
            { "](" .. clipboard .. ")" },
          }
        end,
        find = "%b[]%b()",
        delete = "^(%[)().-(%]%b())()$",
        change = {
          target = "^()()%b[]%((.-)()%)$",
          replacement = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "" },
              { clipboard },
            }
          end,
        },
      },
    },
  })
end

-- There should be no restriction for 80-char limit in markdown files, so wrap
-- them but don't break them in the middle of a word (easier to read that way)
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = ""

-- Enable spell
vim.opt_local.spell = true
