local M = {
	"norcalli/nvim-colorizer.lua",
	event = "LazyFile",
}

function M.config()
	require("colorizer").setup({
		"*",
	}, {
		RGB = true,
		RRGGBB = true,
		names = false,
		RRGGBBAA = false,
		rgb_fn = false,
		hsl_fn = false,
		css = false,
		css_fn = false,

		-- Available modes: foreground, background
		mode = "background",
	})
	vim.cmd("ColorizerReloadAllBuffers")
end

return M
