local M = {}

function M.setup(opts)
	vim.diagnostic.config(opts.diagnostics)

	if opts.debug then
		vim.lsp.set_log_level("debug")
	end
end

return M
