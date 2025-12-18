local M = {
	"lewis6991/gitsigns.nvim",
	opts = {
		sign_priority = 5,
		current_line_blame_opts = {
			delay = 300,
		},
	},
	keys = {
		{ "<leader>b", ":Gitsigns toggle_current_line_blame<CR>" },
	},
	event = "LazyFile",
}

return M
