-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'GJM (terminal.sexy)'
config.color_scheme = 'Gogh (Gogh)'

config.font = wezterm.font 'JetBrains Mono'

-- config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
