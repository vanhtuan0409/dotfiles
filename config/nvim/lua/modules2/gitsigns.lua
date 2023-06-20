local M = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	local gitsigns = require("gitsigns")
	gitsigns.setup({
		sign_priority = 5,
	})

	vim.api.nvim_create_user_command("GitBlame", function(params)
		gitsigns.blame_line({ full = false })
	end, { bang = true })
end

return M
