local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			name = "dapui",
			config = function()
				require("modules2.debugging.ui")
			end,
		},
		"nvim-telescope/telescope-dap.nvim",
	},
	keys = require("modules2.debugging.dap").keys,
	opts = {
		adapters = {},
		configurations = {},
	},
	config = require("modules2.debugging.dap").config,
}

return M
