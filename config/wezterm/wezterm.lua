local wezterm = require("wezterm")

local color_scheme = "Gruvbox Material (Gogh)"
local pached_scheme = wezterm.get_builtin_color_schemes()[color_scheme]
pached_scheme.background = "#32302f"
pached_scheme.foreground = "#dfbf8e"
pached_scheme.cursor_fg = "black"

local config = {
	color_schemes = {
		[color_scheme] = pached_scheme,
	},
	color_scheme = color_scheme,
	font = wezterm.font("JetBrains Mono NL", { weight = "Medium" }),
	font_size = 11,
	freetype_load_flags = "NO_HINTING",
	anti_alias_custom_block_glyphs = false,
	enable_tab_bar = false,
}

return config
