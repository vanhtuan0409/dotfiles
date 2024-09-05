local utils = require("utils")
local group = utils.augroup("GoLsp")

return function(client, bufnr)
	vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = group,
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
