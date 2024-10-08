require("globals")
require("filetype")
require("options")
require("plugins")
require("keybindings")
require("commands")

local utils = require("utils")

local function big_file_disable(bufnr)
	local threshold = 512 * 1024 -- 512Kb
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size > threshold then
		vim.opt_local.syntax = "off"
		vim.api.nvim_buf_set_var(bufnr, "bigfile", true)
	end
end

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
	group = utils.augroup("big_file"),
	pattern = "*",
	callback = function(params)
		big_file_disable(params.buf)
	end,
})

local original_notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end
	original_notify(msg, ...)
end
