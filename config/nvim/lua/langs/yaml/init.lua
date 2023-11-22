local scfg = require("modules2.lsp.server_config")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "yaml" })
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
				yamlls = {
					on_new_config = function(new_config)
						new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
						new_config.settings.yaml.schemas = require("schemastore").yaml.schemas()
					end,
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							validate = true,
							schemaStore = {
								enable = false,
								url = "",
							},
						},
					},
				},
			},
			attachs = {
				yamlls = function(client, bufnr)
					require("langs.yaml.schema")(client, bufnr)
				end,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "yaml-language-server" })
		end,
	},
}
