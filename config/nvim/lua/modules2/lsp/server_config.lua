local M = {}

function M.get_capabilities()
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)
	if require("utils").has("ufo") then
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end
	return capabilities
end

function M.enable_formatting(client)
	client.server_capabilities["documentFormattingProvider"] = true
	client.server_capabilities["documentRangeFormattingProvider"] = true
end

function M.enable_codelens(client)
	client.server_capabilities["codeLensProvider"] = true
end

function M.enable_semantic_token(client)
	client.server_capabilities["semanticTokensProvider"] = true
end

function M.disable_formatting(client)
	client.server_capabilities["documentFormattingProvider"] = false
	client.server_capabilities["documentRangeFormattingProvider"] = false
end

function M.on_attach(client, bufnr)
	client.server_capabilities["codeLensProvider"] = false
	client.server_capabilities["semanticTokensProvider"] = false

	require("modules2.lsp.ext.keymaps")(client, bufnr)
	require("modules2.lsp.ext.auto_diagnostic")(client, bufnr)
	-- require("modules2.lsp.ext.auto_inlayhints")(client, bufnr)
	-- require("modules2.lsp.ext.auto_codelenses")(client, bufnr)
	require("modules2.lsp.ext.auto_codeaction")(client, bufnr)
	require("modules2.lsp.ext.navic")(client, bufnr)
end

function M.setup(server_name, server_config, attach_config)
	local server_opts = vim.tbl_deep_extend("force", {
		capabilities = M.get_capabilities(),
	}, server_config or {})

	server_opts.on_attach = function(client, bufnr)
		M.on_attach(client, bufnr)
		-- execute custom on_attach if exists
		if attach_config then
			attach_config(client, bufnr)
		end
	end

	require("lspconfig")[server_name].setup(server_opts)
end

return M
