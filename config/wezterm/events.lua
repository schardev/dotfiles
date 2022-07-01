local M = {}
local wezterm = require("wezterm")
local utils = require("utils")

M.setup = function()
    -- `update-right-status` is emitted based on the interval specified by the
    -- `status_update_interval` configuration value (default 1000)
    wezterm.on("update-right-status", function(window, pane)
        local proc_name = pane:get_foreground_process_name()
        local overrides = window:get_config_overrides() or {}

        -- Change global leader inside tmux since I use the same leader in wezterm
        if utils.basename(proc_name) == "tmux" then
            if not overrides.leader then
                overrides.leader = { key = "a", mods = "CTRL|ALT" }
            end
        else
            overrides.leader = nil -- fallback to main leader
        end
        window:set_config_overrides(overrides)

        -- Show which key table is active in the status area
        -- Also show when leader is active
        local name = window:active_key_table()
        if name then
            name = "TABLE: " .. name
        elseif window:leader_is_active() then
            name = "LEADER"
        end
        window:set_right_status(name or "")
    end)
end

return M
