local M = {}

function M.setup(opts)
	vim.diagnostic.config(opts.diagnostics)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.popup)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.popup)

	if opts.debug then
		vim.lsp.set_log_level("debug")
	end
end

return M
