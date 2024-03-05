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
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				hcl = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				terraformls = {
					init_options = {
						terraform = {
							path = "/home/tuan/.local/share/nvim/mason/packages/terraform-ls/terraform-ls",
						},
					},
				},
			},
		},
	},
}
