local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local _M = transform_mod({
	multi_open = function(prompt_bufnr)
		local picker = action_state.get_current_picker(prompt_bufnr)
		local selections = picker:get_multi_selection()
		if not vim.tbl_isempty(selections) then
			actions.close(prompt_bufnr)
			for _, entry in ipairs(selections) do
				local filename = entry.path or entry.filename
				pcall(vim.cmd, string.format("edit %s", filename))
			end
		else
			actions.select_default(prompt_bufnr)
		end
	end,
})

return _M
