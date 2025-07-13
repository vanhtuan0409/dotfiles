local utils = require("utils")
local function disable_bigfile(lang, bufnr)
	local ok, res = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile")
	return ok and res
end

local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = { "VeryLazy", "LazyFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			ensure_installed = {
				"bash",
				"fish",
				"comment",
				"query",
				"yuck",
				"ini",
				"hocon",
				"make",
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
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				opts.ensure_installed = utils.dedup(opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "VeryLazy", "LazyFile" },
		opts = {
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
		},
	},
	{
		"aaronik/treewalker.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "VeryLazy", "LazyFile" },
		opts = {
			highlight = false,
			jumplist = true,
		},
		keys = {
			{
				"<C-k>",
				"<cmd>Treewalker Up<cr>",
				silent = true,
			},
			{
				"<C-j>",
				"<cmd>Treewalker Down<cr>",
				silent = true,
			},
			{
				"<C-h>",
				"<cmd>Treewalker Left<cr>",
				silent = true,
			},
			{
				"<C-l>",
				"<cmd>Treewalker Right<cr>",
				silent = true,
			},
		},
	},
}

return M
