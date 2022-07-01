local wezterm = require("wezterm")
local events = require("events")
local keybindings = require("keybindings")
local catppuccin = require("colors.catppuccin")

-- Setup events
events.setup()

return {
    -- automatically_reload_config = false,
    font = wezterm.font("Hack Nerd Font Mono"),

    -- Debug keycodes/names (open wezterm using another terminal)
    -- debug_key_events = true,

    window_frame = {
        active_titlebar_bg = catppuccin.colors.base,
        inactive_titlebar_bg = catppuccin.colors.base,
    },
    -- window_background_opacity = 0.5,

    -- Tab bar
    -- hide_tab_bar_if_only_one_tab = true,
    -- tab_bar_at_bottom = true,
    -- use_fancy_tab_bar = false,

    -- Sane behaviour for font sizing in BSPWM
    adjust_window_size_when_changing_font_size = false,

    -- Colorscheme
    colors = catppuccin.scheme,

    -- Keybindings
    disable_default_key_bindings = true,
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
    key_tables = keybindings.key_tables,
    keys = keybindings.keys,
}
