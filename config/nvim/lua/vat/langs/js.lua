return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"css",
				"html",
				"javascript",
				"markdown",
				"tsx",
				"typescript",
				"vue",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "tsgo", "biome" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				deno_fmt = {
					append_args = { "--no-config" },
				},
				biome = {},
			},
			formatters_by_ft = {
				typescript = { "biome" },
				typescriptreact = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				html = { "biome" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local hints = {
				variableTypes = { enabled = false },
				parameterNames = { enabled = "none" },
			}

			opts.servers.tsgo = {
				settings = {
					editor = {
						indentSize = vim.opt.shiftwidth:get(),
					},
					typescript = {
						inlayHints = hints,
					},
					javascript = {
						inlayHints = hints,
					},
				},
				x_custom = {
					code_action_on_save = "source.organizeImports",
				},
			}
		end,
	},
}
