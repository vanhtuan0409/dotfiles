local utils = require("utils")
local function disable_bigfile(lang, bufnr)
	local ok, res = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile")
	return ok and res
end

local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = { "VeryLazy", "LazyFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		opts = {
			ensure_installed = {
				"bash",
				"fish",
				"comment",
				"query",
				"yuck",
				"ini",
				"hocon",
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
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				opts.ensure_installed = utils.dedup(opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

return M
