local M = {}

M.gruvbox = {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = "dark"
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_better_performance = true
		vim.cmd([[colorscheme gruvbox-material]])
	end,
}

return M.gruvbox
