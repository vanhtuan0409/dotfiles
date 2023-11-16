local M = {
	"j-hui/fidget.nvim",
	event = "BufReadPost",
	opts = {
		progress = {
			display = {
				done_ttl = 0.5,
			},
		},
	},
}

return M
