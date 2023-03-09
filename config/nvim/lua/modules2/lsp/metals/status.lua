local M = {}
local global_task_track = {}

local function escape_msg(msg)
	return msg:gsub("[%%]", "%%%1")
end

function M.handler(err, status, result)
	local lsp_status_handler = vim.lsp.handlers["$/progress"]
	local info = { client_id = result.client_id }

	-- helpers
	local send_event = function(task_num, kind, msg)
		local escaped_msg = escape_msg(msg)
		local event = {
			token = task_num,
			value = { kind = kind, message = escaped_msg },
		}
		if kind == "begin" then
			event.value.title = ""
		end

		lsp_status_handler(err, event, info)
	end

	-- handle initialize task entry and send begin
	local task_num = global_task_track[result.client_id] or 0
	if status.show then
		task_num = task_num + 1
		global_task_track[result.client_id] = task_num
		send_event(task_num, "begin", status.text)
		return
	end

	-- handle end logic
	if status.hide then
		send_event(task_num, "end", status.text)
		return
	end

	-- handle msg
	if not status.text then
		return
	end
	send_event(task_num, "report", status.text)
end

return M
