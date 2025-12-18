local M = {}
local spinners = { "", "" }
local utils = require("utils")

function M.attached_lsp()
	local servers = {}
	for _, v in pairs(vim.lsp.get_clients()) do
		table.insert(servers, v.name)
	end
	return table.concat(servers, " ")
end

function M.breadcrumb()
	local default_bar = "%#NavicText#" .. vim.fn.expand("%:.") .. "%*"
	local navic = require("utils").prequire("nvim-navic")
	if not (navic and navic.is_available()) then
		return default_bar
	end

	local bar = navic.get_location()
	if bar == "" then
		return default_bar
	end
	return bar
end

return M
