local cmd = vim.cmd
local opt = vim.opt

vim.g.mapleader = " "

opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.shortmess:append "c"
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.showmode = false
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.lazyredraw = true
opt.updatetime = 200
opt.timeoutlen = 500
opt.signcolumn = "yes"
opt.autowrite = true
opt.hlsearch = true
opt.cursorline = true
opt.scrolloff = 999
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.relativenumber = false
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.hidden = false
opt.title = true
opt.foldlevelstart = 99
opt.foldenable = false
-- opt.cmdheight = 0

vim.schedule(function()
  opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
  vim.cmd [[ silent! rsh ]]
end)
