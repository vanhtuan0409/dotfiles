return function(client, bufnr)
	require("utils").keymap_set_multi("n", {
		["K"] = vim.lsp.buf.hover,
		["<leader>rn"] = vim.lsp.buf.rename,
		["gd"] = vim.lsp.buf.definition,
		["gi"] = function()
			require("telescope.builtin").lsp_implementations()
		end,
		["gr"] = function()
			require("telescope.builtin").lsp_references()
		end,
		["gy"] = vim.lsp.buf.type_definition,
		["<leader>f"] = vim.lsp.buf.format,
		["<leader>ga"] = vim.lsp.buf.code_action,
	}, { silent = true, buffer = bufnr })
end
