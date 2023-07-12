return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "gopls", "goimports", "gofumpt", "gomodifytags", "delve" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							usePlaceholders = false,
							codelenses = {
								test = true,
							},
							staticcheck = true,
							hints = {
								constantValues = true,
							},
						},
					},
				},
			},
			attachs = {
				gopls = function(client, bufnr)
					require("langs.go.organize_import")(client, bufnr)
				end,
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.formatting.gofumpt,
				nls.builtins.code_actions.gomodifytags,
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		opts = {
			adapters = {
				go = {
					type = "server",
					port = "${port}",
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:${port}" },
					},
				},
			},
			configurations = {
				go = {
					{
						type = "go",
						name = "Debug (current dir)",
						request = "launch",
						showLog = false,
						program = "${relativeFileDirname}",
						cwd = "${workspaceFolder}",
					},
				},
			},
		},
	},
}
