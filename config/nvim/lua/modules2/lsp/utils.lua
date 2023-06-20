local M = {}

function M.make_default()
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)
	if require("utils").prequire("ufo") then
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end
	local conf = vim.tbl_deep_extend("force", require("lspconfig").util.default_config, {
		capabilities = capabilities,
	})
	return conf
end

return M
