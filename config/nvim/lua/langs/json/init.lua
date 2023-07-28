return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "json", "jsonc" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			version = false,
		},
		opts = {
			servers = {
				jsonls = {
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						new_config.settings.json.schemas = require("schemastore").json.schemas()
					end,
					settings = {
						json = {
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
