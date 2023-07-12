return function(client, bufnr)
	require("utils").keymap_set_multi("n", {
		["K"] = vim.lsp.buf.hover,
		["<leader>rn"] = vim.lsp.buf.rename,
		["gd"] = vim.lsp.buf.definition,
		["gi"] = vim.lsp.buf.implementation,
		["gr"] = vim.lsp.buf.references,
		["gy"] = vim.lsp.buf.type_definition,
		["<leader>f"] = vim.lsp.buf.format,
		["<leader>ga"] = vim.lsp.buf.code_action,
	}, { silent = true, buffer = bufnr })
end
