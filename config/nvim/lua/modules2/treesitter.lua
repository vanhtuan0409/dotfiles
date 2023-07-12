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
				"fish",
				"comment",
				"query",
				"toml",
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
				disable = {},
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
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

return M
