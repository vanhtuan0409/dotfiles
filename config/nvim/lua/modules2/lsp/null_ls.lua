local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local code_actions = nullls.builtins.code_actions

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

local handler = require("modules2.lsp.on_attach").make_on_attach()
nullls.setup({
	default_timeout = 500,
	on_attach = handler.on_attach,
	sources = {
		formatting.gofumpt,
		formatting.rustfmt,
		formatting.black,
		formatting.prettierd,
		formatting.terraform_fmt.with({
			filetypes = { "terraform", "tf", "terraform-vars", "hcl" },
		}),
		formatting.trim_newlines,
		formatting.trim_whitespace,
		formatting.stylua,

		code_actions.gomodifytags,
	},
})
