local M = {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = {
				enabled = true,
				size = 512 * 1024, -- 512Kb,
			},
			input = { enabled = true },
			picker = { enabled = true },
			indent = { enabled = true },
			scroll = { enabled = true },
			notifier = {
				enabled = true,
				margin = { top = 0, right = 1, bottom = 1 },
				level = vim.log.levels.INFO,
				top_down = false,
				filter = function(notif)
					if string.match(string.lower(notif.msg), "no code action") then
						return false
					end
					return true
				end,
			},
		},
		init = function()
			vim.api.nvim_create_user_command("Bonly", function(params)
				Snacks.bufdelete.other({
					wipe = true,
				})
			end, { bang = true })
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},
}

return M
