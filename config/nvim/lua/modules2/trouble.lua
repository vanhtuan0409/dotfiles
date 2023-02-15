local M = {
	"folke/trouble.nvim",
	cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
	keys = {
		{ "<leader>d", ":TroubleToggle document_diagnostics<cr>" },
	},
	opts = {
		height = 8,
		icons = false,
		mode = "document_diagnostics",
		use_diagnostic_signs = true,
		action_keys = {
			close = { "q", "<C-d>" },
		},
	},
}

return M
