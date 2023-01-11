require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					gtd = "~/Dropbox/neorgs/gtd",
				},
				autochdir = false,
			},
		},
		["core.gtd.base"] = {
			config = {
				workspace = "gtd",
			},
		},
		["core.gtd.ui"] = {},
	},

	hook = function()
		require("modules.neorg.keybinds")
	end,
})

-- Start neorg automatically
vim.cmd([[silent! NeorgStart silent=true]])
vim.api.nvim_create_user_command("GtdView", "Neorg gtd views", { bang = true })
vim.api.nvim_create_user_command("GtdCapture", "Neorg gtd capture", { bang = true })
