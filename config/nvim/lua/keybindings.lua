local utils = require("utils")
local map = vim.keymap.set

map("n", "<leader>a", "<Esc>ggVG<CR>")
map("n", "<leader>l", ":noh<CR>")
map("n", "<S-Enter>", "O<Esc>")
map("i", "jj", "<Esc>")
map("n", "<CR>", "o<Esc>")

-- unmap <CR> on quickfix
vim.api.nvim_create_autocmd("FileType", {
	group = utils.augroup("quickfix-unmap"),
	pattern = { "qf" },
	callback = function(ev)
		map("n", "<CR>", "<CR>")
	end,
})

-- Quickly goback
map("n", "<BS>", "<C-o>")

-- Smart home
map("n", "0", [[col('.') == match(getline('.'),'\S')+1 ? '0' : '^']], { expr = true, silent = true })

-- Smart move around
map("n", "j", "gj")
map("n", "k", "gk")

-- Quick list move
map("n", "<leader>p", ":cprevious<CR>")
map("n", "<leader>n", ":cnext<CR>")

map("n", "<C-s>", ":w<CR>")

-- Navigate pane
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l") -- override default nvim mapping to <C-l>

-- Buffer operation
map("n", "<C-d>", ":bd<CR>")
map("n", "<C-w>", ":bufdo :bd<CR>")
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")
