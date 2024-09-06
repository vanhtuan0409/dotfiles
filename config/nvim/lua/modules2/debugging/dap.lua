local M = {}

M.keys = {
	{
		"<F1>",
		function()
			require("dap").terminate()
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

function M.config(_, opts)
	local dap = require("dap")
	for lang, config in pairs(opts.adapters) do
		dap.adapters[lang] = config
	end
	for lang, config in pairs(opts.configurations) do
		dap.configurations[lang] = config
	end

	require("telescope").load_extension("dap")
	local vscode_ext = require("dap.ext.vscode")
	local json = require("plenary.json")
	vscode_ext.json_decode = function(str)
		return vim.json.decode(json.json_strip_comments(str))
	end
	if vim.fn.filereadable(".vscode/launch.json") then
		vscode_ext.load_launchjs()
	end
end

return M
