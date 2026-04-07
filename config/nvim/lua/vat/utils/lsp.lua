local M = {}

--- Synchronously apply a code action by kind (blocks until LSP responds).
--- Use this in BufWritePre to avoid the async-modify-after-write loop.
--- ref: https://github.com/neovim/neovim/issues/31176
--- ref: https://github.com/neovim/neovim/issues/25259
function M.sync_action(action_kind, bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params(0, "utf-8")
	params.context = { only = { action_kind }, diagnostics = {} }

	local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
	if not results then
		return
	end

	for _, res in pairs(results) do
		for _, action in ipairs(res.result or {}) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			end
			if action.command then
				local cmd = type(action.command) == "table" and action.command or action
				vim.lsp.buf.execute_command(cmd)
			end
		end
	end
end

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = {},
				},
			})
		end
	end,
})

return M
