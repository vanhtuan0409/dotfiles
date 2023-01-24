local M = {}

M.keys = {
	{
		"<F1>",
		function()
			require("dap").disconnect()
			require("dap").repl.close()
			require("dap").close()
			require("dapui").close()
		end,
	},
	{
		"<F2>",
		function()
			require("dap.breakpoints").clear()
		end,
	},
	{
		"<F5>",
		function()
			require("dap").continue()
		end,
	},
	{
		"<F9>",
		function()
			require("dap").toggle_breakpoint()
		end,
	},
	{
		"<F10>",
		function()
			require("dap").step_over()
		end,
	},
	{
		"<F11>",
		function()
			require("dap").step_into()
		end,
	},
	{
		"<F12>",
		function()
			require("dap").step_out()
		end,
	},
}

function M.config()
	require("modules2.debugging.adapters.go")
	require("modules2.debugging.adapters.scala")
	require("telescope").load_extension("dap")

	local vscode_ext = require("dap.ext.vscode")
	local ok, _ = pcall(vscode_ext.load_launchjs)
	if not ok then
		vim.api.nvim_echo({ { "Nvim DAP unable to load vscode extension", "WarningMsg" } }, true, {})
	end
end

return M
