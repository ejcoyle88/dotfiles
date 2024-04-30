local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.default_cwd = '~'
config.default_prog = { 'tmux' }
config.font = wezterm.font_with_fallback {
    'JetBrains Mono'
}
config.font_size = 16
config.color_scheme = 'Tokio Night Moon (Gogh)'
config.audible_bell = 'Disabled'
config.hide_tab_bar_if_only_one_tab = true

return config
