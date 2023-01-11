local actions = require("fzf-lua.actions")

require("utils").keymap_set_multi("n", {
	["<C-p>"] = ":FzfLua files<CR>",
	["<C-f>"] = ":FzfLua live_grep<CR>",
})

require("fzf-lua").setup({
	actions = {
		files = {
			["default"] = actions.file_edit,
		},
	},
})
