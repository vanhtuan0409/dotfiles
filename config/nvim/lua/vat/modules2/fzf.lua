function default_pickers()
	local FzfLua = require("fzf-lua")
	local pickers = { "autocmds", "highlights", "commands", "keymaps" }
	table.sort(pickers)

	FzfLua.fzf_exec(pickers, {
		prompt = "Pickers> ",
		actions = {
			["default"] = function(selected)
				FzfLua[selected[1]]()
			end,
		},
	})
end

local M = {
	"ibhagwan/fzf-lua",
	enabled = true,
	keys = {
		{ "<C-p>", ":FzfLua files<CR>", desc = "Files" },
		{ "<C-b>", ":FzfLua buffers<CR>", desc = "Buffers" },
		{ "<C-f>", ":FzfLua live_grep<CR>", desc = "Search" },
		{ "<leader>t", default_pickers, desc = "Fzf pickers" },
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
