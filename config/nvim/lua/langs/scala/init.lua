return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "java", "scala" })
		end,
	},
	{
		"scalameta/nvim-metals",
		init = function()
			require("langs.scala.metals").init()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		opts = {
			configurations = {
				scala = {
					{
						type = "scala",
						request = "launch",
						name = "Run or Test Target",
						metals = {
							runType = "runOrTestFile",
						},
					},
					{
						type = "scala",
						request = "launch",
						name = "Test Target",
						metals = {
							runType = "testTarget",
						},
					},
				},
			},
		},
	},
}
