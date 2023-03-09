local M = {
	"j-hui/fidget.nvim",
	event = "BufReadPost",
	opts = {
		timer = {
			fidget_decay = 300,
			task_decay = 300,
		},
		sources = {
			["null-ls"] = {
				ignore = true,
			},
		},
	},
}

return M
