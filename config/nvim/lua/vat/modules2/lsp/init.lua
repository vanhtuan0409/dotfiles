local utils = require("vat.utils")

local M = {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "mason.nvim" },
		opts = {
			debug = false,
			diagnostics = {
				underline = false,
				virtual_text = false,
				signs = {
					priority = 999,
				},
				update_in_insert = false,
				severity_sort = true,
				float = {
					source = "always",
					focusable = false,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = utils.icons.diagnostics.ERROR,
						[vim.diagnostic.severity.WARN] = utils.icons.diagnostics.WARN,
						[vim.diagnostic.severity.INFO] = utils.icons.diagnostics.INFO,
						[vim.diagnostic.severity.HINT] = utils.icons.diagnostics.HINT,
					},
				},
			},
			servers = {},
		},
		config = function(_, opts)
			require("vat.modules2.lsp.opts").setup(opts)
			for server_name, server_config in pairs(opts.servers) do
				require("vat.modules2.lsp.server_config").setup(server_name, server_config)
			end
		end,
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
}

return M
