return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "yaml" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {
					settings = {
						yaml = {
							schemas = {},
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
