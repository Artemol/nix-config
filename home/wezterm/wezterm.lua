require 'status'
require 'format'
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.automatically_reload_config = true

-- config.color_scheme = 'iceberg-dark'
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.9

config.font = wezterm.font("HackGen35 Console NF", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12.5

-- Keyconfig
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

config.status_update_interval = 1000

return config
