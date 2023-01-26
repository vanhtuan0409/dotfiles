local actions = require("telescope.actions")
local custom_actions = require("modules2.telescope.custom_actions")
local telescope = require("telescope")
telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
		sorting_strategy = "ascending",
		file_ignore_patterns = {
			".git/",
			"node_modules/",
			"target/",
			"bin/",
			"vendor/",
			"build/",
			".terraform/",
			".bloop/",
		},
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
			no_ignore = true,
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
		["ui-select"] = {},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
