local function getStatus(client, bufnr)
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(),
	}
	local result = client.request_sync("textDocument/codeLens", params, 200, bufnr) or {}
	result = result.result or {}
	if #result == 0 then
		return nil
	end

	return vim.tbl_map(function(item)
		return item.command.arguments[1]
	end, result)
end

local function shortenLink(schema)
	local parts = vim.split(schema, "/")
	local count = #parts
	return string.format("schema://%s", parts[count])
end

return function(client, bufnr)
	local timer = vim.loop.new_timer()
	timer:start(
		1500,
		500,
		vim.schedule_wrap(function()
			local schemas = getStatus(client, bufnr, params)
			if not schemas then
				return
			end
			timer:close()

			schemas = vim.tbl_map(shortenLink, schemas)
			local status = table.concat(schemas, " | ")
			vim.b["jsonschema"] = status
		end)
	)
end
