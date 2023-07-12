require("lazy_init")
require("lazy").setup({
	spec = {
		{ import = "modules2" },
		{ import = "langs" },
	},
	defaults = {
		lazy = true,
	},
	change_detection = {
		enabled = false,
	},
	dev = {
		path = "~/Workspaces/oss",
		fallback = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"matchit",
				"spellfile_plugin",
				"spellfile",
				"fzf",
				"zip",
				"zipPlugin",
				"tar",
				"tarPlugin",
				"vimball",
				"vimballPlugin",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"gzip",
				"2html_plugin",
				"tohtml",
				"tutor",
				"tutor_mode_plugin",
				"rplugin",
				"rrhelper",
				"node_provider",
				"perl_provider",
				"python3_provider",
				"ruby_provider",
				"bugreport",
			},
		},
	},
})
