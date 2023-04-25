local M = {
	{ "nvim-lua/plenary.nvim" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
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
