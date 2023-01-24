local M = {
	"hoob3rt/lualine.nvim",
	event = "VeryLazy",
}

function M.config()
	local modules = require("modules2.lualine.modules")
	local default_bg = vim.opt.background:get()
	require("lualine").setup({
		options = {
			theme = "auto",
			icons_enabled = false,
			section_separators = "",
			component_separators = { left = "|", right = "|" },
			globalstatus = true,
			disabled_filetypes = {
				winbar = { "dap-repl" },
			},
		},
		sections = {
			lualine_a = {
				{ "mode", upper = true },
			},
			lualine_b = {
				"filename",
			},
			lualine_c = {},
			lualine_x = {
				"g:metals_status",
				modules.lsp_message,
				modules.attached_lsp,
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
					colored = false,
				},
			},
			lualine_y = {
				{
					"bo:tabstop",
					separator = nil,
					icons_enabled = true,
					icon = { "Tabs:" },
					color = "WarningMsg",
				},
				{ "filetype" },
			},
			lualine_z = {
				{ "location" },
			},
		},
		tabline = {
			lualine_a = { "buffers" },
			lualine_z = { "tabs" },
		},
		winbar = {
			lualine_a = {
				{
					modules.breadcrumb,
					color = { bg = default_bg },
				},
			},
			lualine_z = {
				{
					"b:jsonschema",
					color = "LspCodeLens",
				},
			},
		},
	})
end

return M
