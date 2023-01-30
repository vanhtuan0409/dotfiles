local utils = require("utils")
local popup_opts = {
	border = "rounded",
	focusable = false,
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
	-- supress NULL_LS error msg
	if err and vim.startswith(ctx.params.command, "NULL_LS") and ctx.client_id ~= ctx.params.client_id then
		return
	end
	return default_exe_handler(err, result, ctx, config)
end

vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	signs = {
		priority = 999,
	},
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "always",
		border = "rounded",
		focusable = false,
	},
})

local diagnostic_icons = utils.icons.diagnostics
for name, icon in pairs(diagnostic_icons) do
	local sign_name = "DiagnosticSign" .. name
	vim.fn.sign_define(sign_name, { text = icon, texthl = name, numhl = "" })
end
