local M = {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {
			filter = function(mapping)
				return mapping.desc and mapping.desc ~= ""
			end,
			spec = {},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}

return M
