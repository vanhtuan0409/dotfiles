local utils = require("utils")

local M = {
	"williamboman/mason.nvim",
	cmd = "Mason",
	opts = {
		install_root_dir = MASON_INSTALL_PATH,
		ensure_installed = {},
	},
	config = function(plugin, opts)
		require("mason").setup(opts)
		local mr = require("mason-registry")
		local ensure_installed = utils.dedup(opts.ensure_installed)
		for _, tool in ipairs(ensure_installed) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end,
}

return M
