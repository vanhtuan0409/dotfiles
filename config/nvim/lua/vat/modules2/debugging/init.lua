local M = {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
		},
		keys = require("vat.modules2.debugging.dap").keys,
		opts = {
			adapters = {},
			configurations = {},
		},
		config = require("vat.modules2.debugging.dap").config,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		name = "dapui",
		config = function()
			require("vat.modules2.debugging.ui")
		end,
	},
}

return M
