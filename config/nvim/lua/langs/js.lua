return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"css",
				"html",
				"javascript",
				"markdown",
				"tsx",
				"typescript",
				"vue",
				"graphql",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "prettier", "prettierd", "typescript-language-server" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				typescript = { "deno_fmt" },
				javascript = { "deno_fmt" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers.ts_ls = {}
		end,
	},
}
