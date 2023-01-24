local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			name = "dapui",
			config = function()
				require("modules2.debugging.ui")
			end,
		},
		"nvim-telescope/telescope-dap.nvim",
	},
	keys = require("modules2.debugging.dap").keys,
	config = require("modules2.debugging.dap").config,
}

return M
