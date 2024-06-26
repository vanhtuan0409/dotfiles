return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork", "proto" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "gopls", "goimports", "gofumpt", "gomodifytags", "delve" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = { "gofumpt" },
			},
		},
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
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							hints = {
								functionTypeParameters = true,
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
