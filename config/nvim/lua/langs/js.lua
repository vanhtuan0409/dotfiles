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
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "prettier", "prettierd", "typescript-language-server", "vtsls" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				deno_fmt = {
					append_args = { "--no-config" },
				},
			},
			formatters_by_ft = {
				typescript = { "deno_fmt" },
				typescriptreact = { "deno_fmt" },
				javascript = { "deno_fmt" },
				javascriptreact = { "deno_fmt" },
				html = { "deno_fmt" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers.vtsls = {}
		end,
	},
}
