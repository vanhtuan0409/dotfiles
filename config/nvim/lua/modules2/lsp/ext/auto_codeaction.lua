local utils = require("utils")
local group = utils.augroup("LspCodeAction")

return function(client, bufnr)
	local codeaction_method = "textDocument/codeAction"
	if client.supports_method(codeaction_method) then
		local lightbulb = require("nvim-lightbulb")

		vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = bufnr,
			callback = function(params)
				lightbulb.update_lightbulb()
			end,
		})
	end
end
