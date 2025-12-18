local function on_list(options)
	vim.fn.setqflist({}, " ", options)
	require("trouble").open("quickfix")
end

return function(client, bufnr)
	local lsp_opts = { on_list = on_list }
	require("vat.utils").keymap_set_multi("n", {
		["K"] = vim.lsp.buf.hover,
		["<leader>rn"] = vim.lsp.buf.rename,
		["gd"] = vim.lsp.buf.definition,
		["gi"] = function()
			vim.lsp.buf.implementation(lsp_opts)
		end,
		["gr"] = function()
			vim.lsp.buf.references(nil, lsp_opts)
		end,
		["gy"] = vim.lsp.buf.type_definition,
		["<leader>f"] = vim.lsp.buf.format,
		["<leader>ga"] = vim.lsp.buf.code_action,
	}, { silent = true, buffer = bufnr })
end
