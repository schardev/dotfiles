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
-- them but don't break words (easier to read that way)
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.colorcolumn = ""

vim.opt_local.spell = true
