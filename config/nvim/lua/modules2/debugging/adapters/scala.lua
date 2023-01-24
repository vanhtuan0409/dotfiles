local dap = require("dap")

dap.configurations.scala = {
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
}
