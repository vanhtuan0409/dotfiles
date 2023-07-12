local M = {}

function M.setup(opts)
	vim.diagnostic.config(opts.diagnostics)
	for name, icon in pairs(opts.diagnostic_icons) do
		local sign_name = "DiagnosticSign" .. name
		vim.fn.sign_define(sign_name, { text = icon, texthl = name, numhl = "" })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.popup)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.popup)

	if opts.debug then
		vim.lsp.set_log_level("debug")
	end
end

return M
