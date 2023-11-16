local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- For alternative color schemes visit:
-- https://wezfurlong.org/wezterm/colorschemes/index.html, e.g.
--   - 'Gruvbox Dark (Gogh)'
--   - 'GruvboxDarkHard',
--   - 'Solarized Dark Higher Contrast (Gogh)'
config.color_scheme = "Argonaut"
config.colors = {
  -- Cell background color when the current cell is occupied by the cursor and the cursor style is set to Block
  cursor_bg = "#ffffff",
  -- Text color when the current cell is occupied by the cursor
  cursor_fg = "#000000",
  cursor_border = "#aaaaaa",
}
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.font_size = 10
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.9,
}
config.scrollback_lines = 10000
config.warn_about_missing_glyphs = false

return config
