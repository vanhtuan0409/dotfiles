local utils = require("vat.utils")
local function disable_bigfile(lang, bufnr)
	local ok, res = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile")
	return ok and res
end

local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
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
		},
		config = function(_, opts)
			local ts = require("nvim-treesitter")
			local utils = require("vat.utils")

			if type(opts.ensure_installed) == "table" then
				opts.ensure_installed = utils.dedup(opts.ensure_installed)
			end

			ts.install(opts.ensure_installed)

			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = utils.augroup("TreesitterSetup"),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					local buf = event.buf

					pcall(vim.treesitter.start, buf, lang)
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
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
