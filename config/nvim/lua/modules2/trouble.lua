local M = {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{ "<leader>d", ":Trouble diagnostics toggle filter.buf=0<cr>" },
	},
	opts = {
		focus = true,
	},
}

return M
