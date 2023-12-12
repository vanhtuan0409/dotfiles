local wezterm = require("wezterm")
local config = {
	color_scheme = "Gruvbox Material (Gogh)",
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 11,
	anti_alias_custom_block_glyphs = false,
	enable_tab_bar = false,
}

return config
