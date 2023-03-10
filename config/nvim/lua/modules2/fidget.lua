local M = {
	"j-hui/fidget.nvim",
	event = "BufReadPost",
	opts = {
		text = {
			spinner = "dots",
		},
		timer = {
			fidget_decay = 100,
			task_decay = 100,
		},
		sources = {
			["null-ls"] = {
				ignore = true,
			},
		},
	},
}

return M
