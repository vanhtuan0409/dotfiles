local utils = require("utils")

local M = {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{ "<leader>d", ":Trouble diagnostics toggle filter.buf=0<cr>" },
	},
	init = function()
		-- Hijack quickfix with trouble
		vim.api.nvim_create_autocmd("BufRead", {
			group = utils.augroup("trouble-quickfix"),
			callback = function(ev)
				if vim.bo[ev.buf].buftype == "quickfix" then
					vim.schedule(function()
						vim.cmd([[cclose]])
						vim.cmd([[Trouble qflist open]])
					end)
				end
			end,
		})

		-- Toggle quickfix
		vim.keymap.set("n", "<leader>w", function()
			vim.cmd([[Trouble qflist toggle]])
		end)
	end,
	opts = {
		focus = true,
	},
}

return M
