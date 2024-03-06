local M = {}
local spinners = { "", "" }
local utils = require("utils")

function M.lsp_message()
	local data = vim.lsp.util.get_progress_messages()[1]
	if not data then
		return ""
	end

	local msg = data.message or ""
	local percentage = data.percentage or 0
	local title = data.title or ""
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	local content = string.format("%s %s %s (%s%%%%)", spinners[frame + 1], title, msg, percentage)
	return content
end

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
