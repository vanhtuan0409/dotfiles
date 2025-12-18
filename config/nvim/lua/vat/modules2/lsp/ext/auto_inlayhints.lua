return function(client, bufnr)
	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	local inlay_method = "textDocument/inlayHint"
	if client.supports_method(inlay_method) and inlay_hint then
		inlay_hint(bufnr, true)
	end
end
