local enabled = false

local M = {
	{
		"hrsh7th/nvim-cmp",
		enabled = enabled,
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("modules2.cmp.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		enabled = enabled,
		event = "InsertEnter",
		build = "make install_jsregexp",
		config = function()
			require("modules2.cmp.luasnip")
		end,
	},
}

return M
