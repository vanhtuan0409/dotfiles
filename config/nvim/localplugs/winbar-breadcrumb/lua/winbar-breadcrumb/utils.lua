local M = {}

function M.add_hl(text, hl_group)
	return "%#" .. hl_group .. "#" .. text .. "%*"
end

return M
