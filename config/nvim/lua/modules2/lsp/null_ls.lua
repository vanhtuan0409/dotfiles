local M = {}

function M.opts()
	local nls = require("null-ls")
	local formatting = nls.builtins.formatting
	local code_actions = nls.builtins.code_actions
	local handler = require("modules2.lsp.on_attach").make_on_attach()
	return {
		default_timeout = 500,
		on_attach = handler.on_attach,
		sources = {
			formatting.rustfmt,
			formatting.black,
			formatting.deno_fmt,
			formatting.terraform_fmt.with({
				filetypes = { "terraform", "tf", "terraform-vars", "hcl" },
			}),
			formatting.trim_newlines,
			formatting.trim_whitespace,
			formatting.stylua,
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
