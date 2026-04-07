local registry = require("vat.modules2.fzf.registry")

function default_pickers()
	local FzfLua = require("fzf-lua")
	local names = vim.tbl_keys(registry.entries())
	table.sort(names)

	FzfLua.fzf_exec(names, {
		prompt = "Pickers> ",
		actions = {
			["default"] = function(selected)
				registry.entries()[selected[1]](FzfLua)
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
