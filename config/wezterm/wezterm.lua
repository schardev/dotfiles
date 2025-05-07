local wezterm = require("wezterm")
local events = require("events")
local keybindings = require("keybindings")

-- Setup events
events.setup()

local config = wezterm.config_builder()
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 13.5
config.warn_about_missing_glyphs = false
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"

-- Debug keycodes/names (open wezterm using another terminal)
-- config.debug_key_events = true,

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 20
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.enable_wayland = false

-- Colorscheme
local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
scheme.tab_bar.active_tab = {
  bg_color = "#313244",
  fg_color = "#bac2de",
}
config.color_scheme = "Catppuccin Mocha"
config.color_schemes = {
  ["Catppuccin Mocha"] = scheme,
}

-- Keybindings
config.disable_default_key_bindings = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.key_tables = keybindings.key_tables
config.keys = keybindings.keys

return config
