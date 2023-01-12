require("nvim-navic").setup({
	highlight = true,
	separator = "  ",
	depth_limit = 4,
	safe_output = true,
})

vim.api.nvim_set_hl(0, "NavicText", { default = true, link = "LspCodeLens" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, link = "WarningMsg" })
