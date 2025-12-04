local option = vim.api.nvim_buf_get_option
local function bufonly()
	local cur = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if
			bufnr ~= cur
			and vim.api.nvim_buf_is_valid(bufnr)
			and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
		then
			-- soft delete as bwipeout
			vim.api.nvim_set_option_value("buflisted", false, { buf = bufnr })
			if vim.api.nvim_buf_is_loaded(bufnr) then
				vim.api.nvim_buf_delete(bufnr, { unload = true })
			end
		end
	end
end

vim.api.nvim_create_user_command("Bonly", function(params)
	bufonly()
end, { bang = true })
