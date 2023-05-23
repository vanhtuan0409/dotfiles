local M = {
	"b0o/schemastore.nvim",
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			require("modules2.lsp.servers")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			require("modules2.lsp.null_ls")
		end,
	},
	{
		"scalameta/nvim-metals",
		init = function()
			require("modules2.lsp.metals").init()
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = true,
	},
	{
		"SmiteshP/nvim-navic",
		opts = {
			highlight = true,
			separator = "  ",
			depth_limit = 4,
			safe_output = true,
		},
		init = function()
			vim.api.nvim_set_hl(0, "NavicText", { default = true, link = "LspCodeLens" })
			vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, link = "WarningMsg" })
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		keys = {
			{ "<leader>o", ":SymbolsOutline<CR>" },
		},
		opts = {
			highlight_hovered_item = false,
			auto_preview = false,
			width = 30,
		},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		opts = {},
	},
}

return M
