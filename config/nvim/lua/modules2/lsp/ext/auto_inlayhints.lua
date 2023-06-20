return function(client, bufnr)
	local inlay_method = "textDocument/inlayHint"
	if client.supports_method(inlay_method) then
		vim.lsp.inlay_hint(bufnr, true)
	end
end
