if not vim.loop.fs_stat(LAZY_INSTALL_PATH) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		LAZY_INSTALL_PATH,
	})
end
vim.opt.rtp:prepend(LAZY_INSTALL_PATH)

local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = {
	id = "LazyFile",
	event = { "BufReadPost", "BufNewFile" },
}
Event.mappings["User LazyFile"] = Event.mappings.LazyFile
