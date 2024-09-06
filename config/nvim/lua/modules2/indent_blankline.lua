local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "LazyFile",
	opts = {
		scope = {
			show_start = false,
			show_end = false,
			highlight = "WarningMsg",
		},
		exclude = {
			filetypes = {
				"lazy",
				"mason",
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
				"",
			},
		},
	},
}

return M
