local M = {}

function M.setup()
	vim.keymap.set("n", "<leader>o", ":SymbolsOutline<cr>")
end

function M.config()
	require("symbols-outline").setup({
		highlight_hovered_item = false,
		auto_preview = false,
		width = 30,
	})
end

return M
