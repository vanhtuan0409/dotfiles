local utils = require("utils")

local M = {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{ "<leader>d", ":Trouble diagnostics toggle filter.buf=0<CR>" },
		{ "<leader>w", ":Trouble quickfix toggle<CR>" },
		{ "<leader>o", ":Trouble symbols toggle<CR>" },
	},
	opts = {
		focus = true,
		keys = {
			["<cr>"] = "jump_close",
		},
		modes = {
			symbols = {
				win = {
					position = "right",
					size = { width = 0.3 },
				},
			},
		},
	},
}

return M
