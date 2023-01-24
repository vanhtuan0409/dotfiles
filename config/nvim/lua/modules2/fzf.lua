local M = {
	"ibhagwan/fzf-lua",
	keys = {
		{ "<C-p>", ":FzfLua files<CR>", desc = "Files" },
		{ "<C-f>", ":FzfLua live_grep<CR>", desc = "Search" },
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
