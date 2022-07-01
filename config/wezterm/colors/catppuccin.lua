local M = {}

-- catppuccin `mocha` colorscheme
local colors = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
}

M.scheme = {
    foreground = colors.text,
    background = colors.base,
    cursor_bg = colors.rosewater,
    cursor_border = colors.rosewater,
    cursor_fg = colors.crust,
    selection_bg = colors.surface2,
    selection_fg = colors.text,
    ansi = {
        colors.surface1,
        colors.red,
        colors.green,
        colors.yellow,
        colors.blue,
        colors.pink,
        colors.teal,
        colors.subtext1,
    },
    brights = {
        colors.surface2,
        colors.red,
        colors.green,
        colors.yellow,
        colors.blue,
        colors.pink,
        colors.teal,
        colors.subtext0,
    },
    tab_bar = {
        background = colors.base,
        active_tab = {
            bg_color = colors.surface2,
            fg_color = colors.text,
        },
        inactive_tab = {
            bg_color = colors.base,
            fg_color = colors.text,
        },
        inactive_tab_hover = {
            bg_color = colors.surface2,
            fg_color = colors.text,
        },
        new_tab = {
            bg_color = colors.base,
            fg_color = colors.text,
        },
        new_tab_hover = {
            bg_color = colors.surface2,
            fg_color = colors.text,
            italic = true,
        },
        inactive_tab_edge = colors.base,
    },
    visual_bell = colors.surface0,
    indexed = {
        [16] = colors.peach,
        [17] = colors.rosewater,
    },
    scrollbar_thumb = colors.surface2,
    split = colors.overlay0,
    -- nightbuild only
    compose_cursor = colors.flamingo,
}

M.colors = colors

return M
