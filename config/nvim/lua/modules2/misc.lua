local M = {
	{ "nvim-lua/plenary.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {
			pre_hook = function(ctx)
				require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
			end,
		},
	},
}

return M
