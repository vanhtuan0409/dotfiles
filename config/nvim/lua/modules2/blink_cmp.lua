local enabled = true

local M = {
	{
		"saghen/blink.cmp",
		enabled = enabled,
		event = "InsertEnter",
		version = "1.*",
		opts = {
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
