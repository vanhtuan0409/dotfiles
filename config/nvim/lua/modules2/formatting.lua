local function doFormat(bufnr)
	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
		return
	end

	local opts = {
		bufnr = bufnr,
		timeout_ms = 1000,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
		lsp_fallback = true,
	}
	require("conform").format(opts)
end

local M = {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					doFormat(args.buf)
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
		opts = {},
	},
}

return M
