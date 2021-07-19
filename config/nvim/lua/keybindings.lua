local vimp = require("vimp")

vimp.nnoremap("<leader>a", "<Esc>ggVG<CR>")
vimp.nnoremap("<S-Enter>", "O<Esc>")
vimp.nnoremap("<CR>", "o<Esc>")
vimp.imap("jj", "<Esc>")

-- Quickly goback
vimp.nnoremap("<BS>", "<C-o>")

-- Smart home
vimp.nnoremap({"expr", "silent"}, "0", [[col('.') == match(getline('.'),'\S')+1 ? '0' : '^']])

-- Smart move around
vimp.nnoremap("j", "gj")
vimp.nnoremap("k", "gk")
vimp.nnoremap("h", "b")
vimp.nnoremap("l", "w")

-- Quick list move
vimp.nnoremap("<leader>p", ":cprevious<CR>")
vimp.nnoremap("<leader>n", ":cnext<CR>")

vimp.nnoremap("<C-s>", ":w<CR>")

-- Navigate pane
vimp.nnoremap("<C-j>", "<C-W>j")
vimp.nnoremap("<C-k>", "<C-W>k")
vimp.nnoremap("<C-h>", "<C-W>h")
vimp.nnoremap("<C-l>", "<C-W>l")
