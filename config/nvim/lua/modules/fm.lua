local M = {}
local broot_confs = {
	vim.fn.stdpath("data") .. "/site/pack/packer/opt/fm-nvim/assets/broot_conf.hjson",
	vim.fn.expand("$HOME/.config/broot/conf.hjson"),
}

function M.setup()
	vim.keymap.set("n", "<Space><Space>", ":Broot %:p:h<CR>")
end

function M.config()
	local confs = table.concat(broot_confs, ";")
	require("fm-nvim").setup({
		ui = {
			default = "float",
			float = {
				border = "none",
				border_hl = "Normal",
				width = 1,
				height = 1,
			},
			split = {
				size = 75,
			},
		},
		broot_conf = string.format('"%s"', confs),
	})
end

return M
