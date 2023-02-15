local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	cmd = "Telescope",
	keys = {
		{ "<C-b>", ":Telescope buffers show_all_buffers=true<CR>" },
		{ "<C-f>", ":Telescope live_grep<CR>" },
		{ "<C-p>", ":Telescope find_files<CR>" },
		{ "<leader>t", ":Telescope builtin include_extensions=true<CR>" },
	},
	config = function()
		require("modules2.telescope.config")
	end,
}

return M
