local lspconfig = require("lspconfig")
local utils = require("modules2.lsp.utils")
local attach = require("modules2.lsp.on_attach")
local installer = require("installer")
require("modules2.lsp.handlers")

-- Set snippet support and status line compatibilities
lspconfig.util.default_config = utils.make_default()

local default_handler = attach.make_on_attach({
	caps = {
		codeLensProvider = false,
	},
})
local nofmt_handler = default_handler.with({
	caps = {
		documentFormattingProvider = false,
		documentRangeFormattingProvider = false,
	},
})

local goext = require("modules2.lsp.ext.go")
local gohandler = nofmt_handler.with({
	middlewares = { goext },
})
lspconfig.gopls.setup({
	cmd = { installer.bin("gopls") },
	on_attach = gohandler.on_attach,
	settings = {
		gopls = {
			usePlaceholders = false,
			codelenses = {
				test = true,
			},
			staticcheck = true,
			buildFlags = {
				"-tags=linux,darwin",
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	cmd = { installer.bin("rust_analyzer") },
	on_attach = nofmt_handler.on_attach,
})

lspconfig.dartls.setup({
	on_attach = nofmt_handler.on_attach,
})

lspconfig.tsserver.setup({
	cmd = { installer.bin("tsserver"), "--stdio" },
	on_attach = nofmt_handler.on_attach,
})

lspconfig.denols.setup({
	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	on_attach = nofmt_handler.on_attach,
})

lspconfig.pyright.setup({
	cmd = { installer.bin("pyright"), "--stdio" },
	on_attach = nofmt_handler.on_attach,
	settings = {
		python = {
			pythonPath = vim.fn.exepath("python"),
			analysis = {
				typeCheckingMode = "off",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

lspconfig.terraformls.setup({
	cmd = { installer.bin("terraform-ls"), "serve" },
	on_attach = nofmt_handler.on_attach,
})

local yamlext = require("modules2.lsp.ext.yaml")
local yamlhandler = nofmt_handler.with({
	middlewares = { yamlext },
})
lspconfig.yamlls.setup({
	cmd = { installer.bin("yamlls"), "--stdio" },
	on_attach = yamlhandler.on_attach,
	settings = {
		yaml = {
			schemas = {},
		},
	},
})

local jsonext = require("modules2.lsp.ext.json")
local jsonhandler = nofmt_handler.with({
	middlewares = { jsonext },
})
lspconfig.jsonls.setup({
	cmd = { installer.bin("jsonls"), "--stdio" },
	on_attach = jsonhandler.on_attach,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lspconfig.jdtls.setup({
	on_attach = default_handler.on_attach,
})