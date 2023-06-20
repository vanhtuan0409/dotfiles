local M = {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {
			pre_hook = function(ctx)
				require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
			end,
		},
	},
}

return M
