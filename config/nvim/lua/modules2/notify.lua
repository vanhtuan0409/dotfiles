local M = {
	"rcarriga/nvim-notify",
	enabled = false,
	event = "VeryLazy",
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}

return M
