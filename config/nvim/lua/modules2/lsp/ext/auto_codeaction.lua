local utils = require("utils")
local group = utils.augroup("LspCodeAction")

return function(client, bufnr)
	local codeaction_method = "textDocument/codeAction"
	if client.supports_method(codeaction_method) then
	end
end
