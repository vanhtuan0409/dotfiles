local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
	}),
	experimental = {
		-- ghost_text = {
		-- 	hl_group = "CmpGhostText",
		-- },
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
