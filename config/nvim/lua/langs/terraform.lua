return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "hcl" })
			vim.treesitter.language.register("hcl", "terraform")
			vim.treesitter.language.register("hcl", "terraform-vars")
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "terraform-ls" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				terraformls = {},
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.formatting.terraform_fmt.with({
					filetypes = { "terraform", "tf", "terraform-vars", "hcl" },
				}),
			})
		end,
	},
}
