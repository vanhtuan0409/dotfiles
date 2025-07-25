local metals = require("langs.scala.metals")
local utils = require("utils")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "java", "scala" })
			vim.treesitter.language.register("scala", "mill")
		end,
	},
	-- {
	-- 	"stevearc/conform.nvim",
	-- 	optional = true,
	-- 	opts = {
	-- 		formatters_by_ft = {
	-- 			scala = { "scalafmt" },
	-- 			mill = { "scalafmt" },
	-- 		},
	-- 	},
	-- },
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		ft = { "scala", "java", "mill" },
		opts = function()
			return metals.get_config()
		end,
		config = function(self, config)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				group = utils.augroup("nvim-metals"),
				callback = function()
					vim.api.nvim_create_user_command("StartMetals", function(args)
						metals.force_start_metals(config)
					end, {
						desc = "Force start metals",
						bang = true,
					})
					metals.start_metals(config)
				end,
			})
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
