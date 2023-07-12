local M = {}

function M.opts()
	local nls = require("null-ls")
	local scfg = require("modules2.lsp.server_config")
	local formatting = nls.builtins.formatting
	local code_actions = nls.builtins.code_actions
	return {
		default_timeout = 500,
		on_attach = function(client, bufnr)
			scfg.on_attach(client, bufnr, true)
		end,
		sources = {
			formatting.trim_newlines,
			formatting.trim_whitespace,
		},
	}
end

function M.config(_, opts)
	require("null-ls").setup(opts)
	vim.api.nvim_create_user_command("NullLsToggle", function(params)
		nullls.toggle(params.args)
	end, {
		nargs = 1,
		complete = function()
			local ft = vim.o.filetype
			local sources = require("null-ls.sources").get_available(ft)
			local ret = {}
			for _, src in ipairs(sources) do
				table.insert(ret, src.name)
			end
			return ret
		end,
		bang = true,
	})
end

return M
