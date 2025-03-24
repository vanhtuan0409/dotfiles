VENV_DIRS = { "./venv", "./.venv" }

local function get_python_path()
	for _, d in ipairs(VENV_DIRS) do
		python_path = string.format("%s/bin/python", d)
		if vim.uv.fs_stat(python_path) then
			return python_path
		end
	end
	return vim.fn.expand("python")
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python" })
			vim.list_extend(opts.indent.disable, { "python" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "ruff", "pyright", "basedpyright" })
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				python = { "ruff_format" },
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
				-- pyright = {
				-- 	settings = {
				-- 		python = {
				-- 			pythonPath = get_python_path(),
				-- 			analysis = {
				-- 				typeCheckingMode = "off",
				-- 				autoSearchPaths = true,
				-- 				useLibraryCodeForTypes = true,
				-- 				diagnosticMode = "workspace",
				-- 			},
				-- 		},
				-- 	},
				-- },
			},
		},
	},
}
