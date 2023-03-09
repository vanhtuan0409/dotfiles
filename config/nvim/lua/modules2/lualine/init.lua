local utils = require("utils")

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
			-- component_separators = { left = "│", right = "│" },
			component_separators = { left = "", right = "" },
			globalstatus = true,
			disabled_filetypes = {
				statusline = { "lazy" },
				winbar = { "lazy", "dap-repl" },
			},
		},
		sections = {
			lualine_a = {
				{ "mode", upper = true },
			},
			lualine_b = {
				{ "filetype" },
			},
			lualine_c = {},
			lualine_x = {
				{
					modules.attached_lsp,
					icons_enabled = true,
					icon = { " " },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = utils.icons.diagnostics.Error,
						warn = utils.icons.diagnostics.Warn,
						info = utils.icons.diagnostics.Info,
						hint = utils.icons.diagnostics.Hint,
					},
					colored = false,
				},
			},
			lualine_y = {
				{
					"bo:tabstop",
					icons_enabled = true,
					icon = { "Tabs:" },
				},
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
