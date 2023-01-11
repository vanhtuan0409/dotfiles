local augroup = vim.api.nvim_create_augroup("LspCodeAction", { clear = true })

return function(client, bufnr)
	local codeaction_method = "textDocument/codeAction"
	if client.supports_method(codeaction_method) then
		local lightbulb = require("nvim-lightbulb")

		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = augroup,
			buffer = bufnr,
			callback = function(params)
				lightbulb.update_lightbulb()
			end,
		})
	end
end
