return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "json", "jsonc" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			},
			attachs = {
				jsonls = function(client, bufnr)
					require("langs.json.schema")(client, bufnr)
				end,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "json-lsp" })
		end,
	},
}
