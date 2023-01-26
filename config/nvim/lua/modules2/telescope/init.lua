local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	event = "BufReadPost",
	keys = {
		{ "<C-b>", ":Telescope buffers<CR>" },
		{ "<leader>t", ":Telescope builtin include_extensions=true<CR>" },
	},
	config = function()
		require("modules2.telescope.config")
	end,
}

return M
