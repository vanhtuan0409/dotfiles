local scfg = require("modules2.lsp.server_config")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "c", "cpp" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {},
			},
		},
	},
}
