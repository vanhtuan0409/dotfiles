local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
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
	config = function(_, opts)
		require("ibl").setup(opts)
	end,
}

return M
