local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	opts = {
		char = "│",
		use_treesitter = true,
		filetype_exclude = { "lazy" },
		show_current_context = true,
		context_highlight_list = { "WarningMsg" },
		use_treesitter_scope = false,
	},
}

return M