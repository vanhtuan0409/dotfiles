local augroup = vim.api.nvim_create_augroup("GoLsp", { clear = true })

return function(client, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = augroup,
		buffer = bufnr,
		callback = function(params)
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.organizeImports" },
				},
			})
		end,
	})
end
