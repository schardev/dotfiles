local M = {}
local wezterm = require("wezterm")
local utils = require("utils")
local act = wezterm.action
local callback = wezterm.action_callback

local default = {
    -- Repeat leader to send it to terminal (as wezterm will swallow it otherwise)
    {
        key = "a",
        mods = "LEADER|CTRL",
        action = act.SendKey({ key = "a", mods = "CTRL" }),
    },

    -- Reload config (there's probably no need for it as the config will be
    -- loaded automatically upon change)
    { key = "z", mods = "ALT", action = act.ReloadConfiguration },

    -- Navigating
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "PageUp", mods = "ALT", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "ALT", action = act.ScrollByPage(1) },

    -- Clear scrollback
    {
        key = "k",
        mods = "CTRL|SHIFT",
        action = act.ClearScrollback("ScrollbackOnly"),
    },

    -- Managing tabs/windows
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    -- If CTRL-w inside an editor, send key to the editor instead
    -- (I mapped that key to close buffers in vim)
    {

        key = "w",
        mods = "CTRL",
        action = callback(function(window, pane)
            local proc_name = pane:get_foreground_process_name()
            if utils.is_editor(proc_name) then
                window:perform_action(
                    act.SendKey({ key = "w", mods = "CTRL" }),
                    pane
                )
            else
                window:perform_action(
                    act.CloseCurrentPane({ confirm = true }),
                    pane
                )
            end
        end),
    },

    -- Open debug overlay
    {
        key = "l",
        mods = "CTRL|SHIFT",
        action = act.ShowDebugOverlay,
    },

    -- Find/Select mode
    {
        key = "/",
        mods = "LEADER",
        action = act.Search({ CaseSensitiveString = "" }),
    },
    {
        key = "Space",
        mods = "CTRL|SHIFT",
        action = act.QuickSelect,
    },
    -- {
    --     key = "f",
    --     mods = "CTRL|SHIFT",
    --     action = act.Search({ CaseSensitiveString = "" }),
    -- },

    -- Copy/Paste
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

    -- Font size
    { key = "0", mods = "CTRL", action = act.ResetFontSize },
    { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
}

local tmux = {
    -- Splitting
    {
        key = '"',
        mods = "LEADER|SHIFT",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "%",
        mods = "LEADER|SHIFT",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    {
        key = "x",
        mods = "LEADER",
        action = act.CloseCurrentPane({ confirm = true }),
    },

    -- Moving around
    {
        key = "h",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Up"),
    },

    {
        key = "j",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Down"),
    },

    {
        key = "LeftArrow",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Left"),
    },
    {
        key = "RightArrow",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = "UpArrow",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Up"),
    },
    {
        key = "DownArrow",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Down"),
    },

    -- Use resize_pane table
    {
        key = "r",
        mods = "LEADER",
        action = act.ActivateKeyTable({
            name = "resize_pane",
            one_shot = false,
            replace_current = true,
        }),
    },
}

local resize_pane = {
    {
        key = "LeftArrow",
        mods = "ALT",
        action = act.AdjustPaneSize({ "Left", 1 }),
    },
    {
        key = "RightArrow",
        mods = "ALT",
        action = act.AdjustPaneSize({ "Right", 1 }),
    },
    {
        key = "UpArrow",
        mods = "ALT",
        action = act.AdjustPaneSize({ "Up", 1 }),
    },
    {
        key = "DownArrow",
        mods = "ALT",
        action = act.AdjustPaneSize({ "Down", 1 }),
    },

    -- Cancel the mode by pressing escape
    { key = "Escape", action = "PopKeyTable" },
}

local copy_mode = {
    -- Closing
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "q", mods = "CTRL", action = act.CopyMode("Close") },

    -- Navigating
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

    { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

    { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
    { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

    -- Move cursor to start/end of a word
    { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
    {
        key = "e",
        mods = "NONE",
        action = act({
            Multiple = {
                act.CopyMode("MoveRight"),
                act.CopyMode("MoveForwardWord"),
                act.CopyMode("MoveLeft"),
            },
        }),
    },

    -- Move to start/end within a line
    { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
    {
        key = "$",
        mods = "NONE",
        action = act.CopyMode("MoveToEndOfLineContent"),
    },
    {
        key = "$",
        mods = "SHIFT",
        action = act.CopyMode("MoveToEndOfLineContent"),
    },
    {
        key = "^",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfLineContent"),
    },
    {
        key = "^",
        mods = "SHIFT",
        action = act.CopyMode("MoveToStartOfLineContent"),
    },
    {
        key = "H",
        mods = "NONE",
        action = act.CopyMode("MoveToStartOfLine"),
    },
    {
        key = "H",
        mods = "SHIFT",
        action = act.CopyMode("MoveToStartOfLine"),
    },
    {
        key = "L",
        mods = "NONE",
        action = act.CopyMode("MoveToEndOfLineContent"),
    },
    {
        key = "L",
        mods = "SHIFT",
        action = act.CopyMode("MoveToEndOfLineContent"),
    },

    -- Select
    {
        key = "v",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Cell" }),
    },
    {
        key = "V",
        mods = "NONE",
        action = act.CopyMode({ SetSelectionMode = "Line" }),
    },
    {
        key = "V",
        mods = "SHIFT",
        action = act.CopyMode({ SetSelectionMode = "Line" }),
    },
    {
        key = "v",
        mods = "CTRL",
        action = act.CopyMode({ SetSelectionMode = "Block" }),
    },

    -- Move to bottom
    {
        key = "G",
        mods = "NONE",
        action = act.CopyMode("MoveToScrollbackBottom"),
    },
    {
        key = "G",
        mods = "SHIFT",
        action = act.CopyMode("MoveToScrollbackBottom"),
    },

    -- Move to top
    {
        key = "g",
        mods = "NONE",
        action = act.CopyMode("MoveToScrollbackTop"),
    },

    {
        key = "M",
        mods = "NONE",
        action = act.CopyMode("MoveToViewportMiddle"),
    },
    {
        key = "M",
        mods = "SHIFT",
        action = act.CopyMode("MoveToViewportMiddle"),
    },

    -- Move to the other end of selection
    {
        key = "o",
        mods = "NONE",
        action = act.CopyMode("MoveToSelectionOtherEnd"),
    },
    {
        key = "O",
        mods = "NONE",
        action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
    },
    {
        key = "O",
        mods = "SHIFT",
        action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
    },

    -- Yank (copy) and exit copy-mode
    {
        key = "y",
        mods = "NONE",
        action = act.Multiple({
            act.CopyTo("Clipboard"),
            act.CopyMode("Close"),
        }),
    },
}

-- Now construct base keybindings tables and export them
M.key_tables = {
    resize_pane = resize_pane,
    copy_mode = copy_mode,
}
M.keys = utils.table.join(default, tmux)

return M
