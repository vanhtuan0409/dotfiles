local actions = require("telescope.actions")
local custom_actions = require("modules2.telescope.custom_actions")
local telescope = require("telescope")
telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		mappings = {
			n = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = false,
			follow = true,
			mappings = {
				n = {
					["<CR>"] = custom_actions.multi_select,
				},
				i = {
					["<CR>"] = custom_actions.multi_select,
				},
			},
		},
	},
	extensions = {
		["fzf"] = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
