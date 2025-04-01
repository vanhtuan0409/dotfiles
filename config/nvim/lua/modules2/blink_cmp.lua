local M = {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		opts = {
			enabled = function()
				return not vim.list_contains({ "lazy", "DressingInput" }, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				-- ["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},
			sources = {
				default = { "lsp", "path", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}

return M
