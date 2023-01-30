local _M = {}
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function _M.multi_select(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local num_selections = table.getn(picker:get_multi_selection())

	if num_selections > 1 then
		actions.send_to_qflist(prompt_bufnr)
		actions.open_qflist(prompt_bufnr)
	else
		actions.file_edit(prompt_bufnr)
	end
end

return _M
