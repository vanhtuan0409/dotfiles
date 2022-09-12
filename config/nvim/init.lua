require("globals")
require("filetype")
require("options")
require("plugins")
require("keybindings")
require("commands")

local function big_file_disable()
  local fpath = vim.fn.expand("%")
  local fsize = vim.fn.getfsize(fpath)
  local threshold = 512 * 1024 -- 512Kb
  if fsize > threshold then
    vim.opt_local.syntax = "off"
    vim.api.nvim_buf_set_var(0, 'bigfile', true)
  end
end

local qf_ag = vim.api.nvim_create_augroup("qf", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = qf_ag,
  pattern = "qf",
  command = "set nobuflisted",
})

local bigfile_ag = vim.api.nvim_create_augroup("big_file", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  group = bigfile_ag,
  pattern = "*",
  callback = function(params)
    big_file_disable()
  end,
})
