return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "gopls", "goimports", "gofumpt", "gomodifytags", "delve" })
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.formatting.gofumpt,
				nls.builtins.code_actions.gomodifytags,
			})
		end,
	},
}
