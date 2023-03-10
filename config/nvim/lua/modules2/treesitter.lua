local function disable_bigfile(lang, bufnr)
	local ok, res = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile")
	return ok and res
end

local M = {
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"go",
				"gomod",
				"html",
				"javascript",
				"markdown",
				"json",
				"lua",
				"python",
				"fish",
				"comment",
				"query",
				"nix",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vue",
				"yaml",
				"hcl",
				"java",
				"scala",
				"graphql",
				"proto",
				"gotmpl",
			},

			highlight = {
				enable = true,
				disable = function(lang, bufnr)
					return disable_bigfile(lang, bufnr)
				end,
			},

			indent = {
				enable = true,
				disable = { "python" },
			},

			playground = {
				enable = true,
			},

			autotag = {
				enable = true,
			},

			context_commentstring = {
				enable = true,
				enable_autocmd = false,
				config = {
					fish = "# %s",
				},
			},
		},
		config = function(plugin, opts)
			vim.treesitter.language.register("hcl", "terraform")
			vim.treesitter.language.register("hcl", "terraform-vars")
			vim.treesitter.language.register("gotmpl", "goyamltmpl")

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.gotmpl = {
				install_info = {
					url = "https://github.com/ngalaiko/tree-sitter-go-template",
					files = { "src/parser.c" },
				},
				filetype = "gotmpl",
				used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" },
			}

			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

return M
