return function(client, bufnr)
	local symbol_method = "textDocument/documentSymbol"
	if client.supports_method(symbol_method) then
		require("nvim-navic").attach(client, bufnr)
	end
end
