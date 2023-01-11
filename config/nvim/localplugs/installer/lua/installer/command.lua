local M = {}
local installer = require("installer")

local subcommands = {
	["ensure"] = function(tool)
		installer.ensure(tool, true)
	end,
	["uninstall"] = installer.uninstall,
	["update_all"] = installer.update_all,
}

local function filter_args(args)
	local res = {}
	for _, v in ipairs(args) do
		if v ~= "" then
			res[#res + 1] = v
		end
	end
	return res
end

function M.complete(args, line, pos)
	local inputs = vim.split(line, " ")
	local filtered = filter_args(inputs)
	if #filtered == 1 then
		return vim.tbl_keys(subcommands)
	elseif #filtered >= 2 then
		if filtered[2] == "ensure" then
			return installer.available_tools()
		elseif filtered[2] == "uninstall" then
			return installer.installed_tools()
		elseif filtered[2] == "update_all" then
			return {}
		else
			return vim.tbl_keys(subcommands)
		end
	else
		return {}
	end
end

function M.load_command(cmd, ...)
	local args = { ... }
	if next(args) ~= nil then
		subcommands[cmd](args[1])
	else
		subcommands[cmd]()
	end
end

return M
