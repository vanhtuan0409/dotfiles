local utils = require("utils")

local M = {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
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
					border = "rounded",
					focusable = false,
				},
			},
			diagnostic_icons = utils.icons.diagnostics,
			popup = {
				border = "rounded",
				focusable = false,
			},
			servers = {},
			attachs = {},
		},
		config = function(_, opts)
			require("modules2.lsp.opts").setup(opts)
			for server_name, server_config in pairs(opts.servers) do
				require("modules2.lsp.server_config").setup(server_name, server_config, opts.attachs[server_name])
			end
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
}

return M
