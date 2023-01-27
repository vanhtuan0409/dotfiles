local dap = require("dap")

dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Debug (current dir)",
		request = "launch",
		showLog = false,
		program = "${relativeFileDirname}",
		cwd = "${workspaceFolder}",
	},
}
