local utils = require("utils")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork", "proto" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "gopls", "goimports", "gofumpt", "gomodifytags", "delve" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = { "gofumpt" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							usePlaceholders = false,
							codelenses = {
								test = true,
							},
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							hints = {
								functionTypeParameters = true,
								constantValues = true,
							},
						},
					},
				},
			},
			attachs = {
				gopls = function(client, bufnr)
					vim.api.nvim_create_autocmd({ "BufWritePre" }, {
						group = utils.augroup("GoLsp"),
						buffer = bufnr,
						callback = function(param)
							utils.lsp.action["source.organizeImports"]()
						end,
					})
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"leoluz/nvim-dap-go",
				opts = {},
			},
		},
		opts = {},
	},
}
