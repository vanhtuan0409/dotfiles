local scfg = require("modules2.lsp.server_config")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "c", "cpp" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "clangd" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {},
			},
			attachs = {
				clangd = function(client, bufnr)
					scfg.enable_formatting(client)
				end,
			},
		},
	},
}
