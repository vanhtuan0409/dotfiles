local utils = require("vat.utils")

local VENV_DIRS = { "./venv", "./.venv" }

local function get_python_path()
	for _, d in ipairs(VENV_DIRS) do
		python_path = string.format("%s/bin/python", d)
		if vim.uv.fs_stat(python_path) then
			return vim.fs.abspath(python_path)
		end
	end
	return vim.fn.expand("python")
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				python = { "ruff_format", "ruff_organize_imports" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					settings = {
						python = {
							pythonPath = get_python_path(),
						},
						basedpyright = {
							analysis = {
								typeCheckingMode = "standard",
							},
						},
					},
				},
			},
		},
	},
}
