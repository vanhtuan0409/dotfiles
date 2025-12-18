local M = {
	"ibhagwan/fzf-lua",
	enabled = true,
	keys = {
		{ "<C-p>", ":FzfLua files<CR>", desc = "Files" },
		{ "<C-b>", ":FzfLua buffers<CR>", desc = "Buffers" },
		{ "<C-f>", ":FzfLua live_grep<CR>", desc = "Search" },
		{ "<leader>t", ":FzfLua builtin<CR>", desc = "Fzf builtin" },
	},
}

function M.config()
	local actions = require("fzf-lua.actions")
	require("fzf-lua").setup({
		actions = {
			files = {
				["default"] = actions.file_edit,
			},
		},
	})
end

return M
