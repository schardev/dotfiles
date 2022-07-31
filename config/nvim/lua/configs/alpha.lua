local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function pick_color()
    math.randomseed(os.time())
    local colors = { "String", "Identifier", "Keyword", "Number" }
    return colors[math.random(#colors)]
end

local function footer()
    local total_plugins = " " .. #vim.tbl_keys(packer_plugins) .. " plugins"
    local ver = vim.version()
    local ver_info =
        string.format(" v%s.%s.%s", ver.major, ver.minor, ver.patch)

    return string.format("%s\t%s", total_plugins, ver_info)
end

local logo = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

dashboard.section.header.val = logo
dashboard.section.header.opts.hl = pick_color()
dashboard.section.buttons.val = {
    dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("<L> s f", "  Find File"),
    dashboard.button("<L> s r", "  Recent files"),
    dashboard.button("<F1>", "  NvimTree", ":NvimTreeToggle<CR>"),
    dashboard.button("pi", "  Packer Sync", ":PackerSync<CR>"),
    dashboard.button("ps", "  Packer Status", ":PackerStatus<CR>"),
    dashboard.button("ch", "  Check Health", ":checkhealth<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

alpha.setup(dashboard.opts)
