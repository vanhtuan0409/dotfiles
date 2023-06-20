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
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"html",
				"javascript",
				"markdown",
				"json",
				"jsonc",
				"lua",
				"python",
				"fish",
				"comment",
				"query",
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
				"yuck",
			},

			highlight = {
				enable = true,
				disable = function(lang, bufnr)
					return disable_bigfile(lang, bufnr)
				end,
				additional_vim_regex_highlighting = false,
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
					hcl = "# %s",
				},
			},
		},
		config = function(plugin, opts)
			vim.treesitter.language.register("hcl", "terraform")
			vim.treesitter.language.register("hcl", "terraform-vars")
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

return M
