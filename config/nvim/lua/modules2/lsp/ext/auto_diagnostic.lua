local augroup = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })

local function open_diagnostic(bufnr, opts)
	local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, "lsp_floating_preview")
	if not (existing_float and vim.api.nvim_win_is_valid(existing_float)) then
		vim.diagnostic.open_float(opts)
	end
end

return function(client, bufnr)
	local diagnostic_method = "textDocument/publishDiagnostics"
	if client.supports_method(diagnostic_method) then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			group = augroup,
			buffer = bufnr,
			callback = function(params)
				open_diagnostic(bufnr, nil)
			end,
		})
	end
end
