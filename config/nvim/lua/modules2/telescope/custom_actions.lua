local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local _M = transform_mod({
	open_all_qf = function(prompt_bufnr)
		local items = vim.fn.getqflist()
		local files = {}
		for _, entry in pairs(items) do
			local bname = vim.fn.bufname(entry.bufnr)
			files[bname] = 1
		end

		for entry in pairs(files) do
			pcall(vim.cmd, string.format("edit %s", entry))
		end
	end,

	multi_open = function(prompt_bufnr)
		local picker = action_state.get_current_picker(prompt_bufnr)
		local selections = picker:get_multi_selection()

		if #selections > 1 then
			require("telescope.pickers").on_close_prompt(prompt_bufnr)
			pcall(vim.api.nvim_set_current_win, picker.original_win_id)

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
