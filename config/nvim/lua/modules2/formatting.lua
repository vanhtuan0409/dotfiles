local M = {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					local opts = {
						bufnr = args.buf,
						timeout_ms = 1000,
						async = false, -- not recommended to change
						quiet = false, -- not recommended to change
						lsp_fallback = true,
					}
					require("conform").format(opts)
				end,
			})
		end,
		opts = {
			format = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
			},
		},
	},
}

return M
