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
				"graphql",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "prettier", "prettierd", "typescript-language-server" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local utils = require("lspconfig.util")
			local is_deno = utils.root_pattern("deno.json", "deno.jsonc")
			opts.servers.tsserver = {
				root_dir = function(fname)
					-- ignore .git root dir
					return utils.root_pattern("tsconfig.json")(fname)
						or utils.root_pattern("package.json", "jsconfig.json")(fname)
				end,
				on_new_config = function(config, root_dir)
					if is_deno(root_dir) then
						config.enabled = false
					end
				end,
			}
			opts.servers.denols = {
				root_dir = is_deno,
			}
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.formatting.deno_fmt,
			})
		end,
	},
}
