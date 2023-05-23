return function(client, bufnr)
	local inlay_method = "textDocument/inlayHint"
	if client.supports_method(inlay_method) then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end
end
