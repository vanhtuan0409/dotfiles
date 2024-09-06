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
