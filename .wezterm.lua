-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "Tokyo Night (Gogh)"
-- config.color_scheme = 'Tokyo Night Day'

-- config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true

config.font = wezterm.font("CaskaydiaCove NF")

return config
