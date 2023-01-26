require("utils").disable_builtins({
	"matchit",
	"spellfile_plugin",
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
	"tutor",
	"tutor_mode_plugin",
	"rplugin",
	"rrhelper",
	"node_provider",
	"perl_provider",
	"python3_provider",
	"ruby_provider",
	"bugreport",
})

require("lazy_init")
require("lazy").setup("modules2", {
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
})
