local M = {}
local utils = require("utils")

function M.get_capabilities()
	cmp_nvim_lsp = utils.prequire("cmp-nvim-lsp")
	blink_cmp = utils.prequire("blink.cmp")
	ufo_cmp = { textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	} }

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or {},
		blink_cmp and blink_cmp.get_lsp_capabilities() or {},
		utils.has("ufo") and ufo_cmp or {}
	)
	return capabilities
end

function M.toggle_formatting(client, enabled)
	client.server_capabilities["documentFormattingProvider"] = enabled
	client.server_capabilities["documentRangeFormattingProvider"] = enabled
end

function M.toggle_codelens(client, enabled)
	client.server_capabilities["codeLensProvider"] = enabled
end

function M.toggle_semantic_token(client, enabled)
	client.server_capabilities["semanticTokensProvider"] = enabled
end

function M.on_attach(client, bufnr)
	M.toggle_codelens(client, false)
	M.toggle_semantic_token(client, false)

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
