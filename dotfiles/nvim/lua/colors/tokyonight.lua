local installed, _ = pcall(require, "tokyonight")

if not installed then
    return
end

local g = vim.g

g.tokyonight_style = "night"
g.tokyonight_italic_keywords = false
