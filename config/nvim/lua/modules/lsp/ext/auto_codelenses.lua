local augroup = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })

return function(client, bufnr)
	local codelens_method = "textDocument/codeLens"
	if client.supports_method(codelens_method) then
		vim.api.nvim_create_user_command("CodeLensRun", function(params)
			vim.lsp.codelens.run()
		end, { bang = true })
		vim.api.nvim_create_user_command("CodeLensRefresh", function(params)
			vim.lsp.codelens.refresh()
		end, { bang = true })

		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = augroup,
			buffer = bufnr,
			callback = function(params)
				vim.lsp.codelens.refresh()
			end,
		})
	end
end
