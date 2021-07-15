local vimp = require("vimp")

vimp.nnoremap({'override'}, "<leader>a", "<Esc>ggVG<CR>")
vimp.nnoremap({'override'}, "<S-Enter>", "O<Esc>")
vimp.nnoremap({'override'}, "<CR>", "o<Esc>")
vimp.imap({'override'}, "jj", "<Esc>")

-- Quickly goback
vimp.nnoremap({'override'}, "<BS>", "<C-o>")

-- Smart home
vimp.nnoremap({'override'}, {"expr", "silent"}, "0", [[col('.') == match(getline('.'),'\S')+1 ? '0' : '^']])

-- Smart move around
vimp.nnoremap({'override'}, "j", "gj")
vimp.nnoremap({'override'}, "k", "gk")
vimp.nnoremap({'override'}, "h", "b")
vimp.nnoremap({'override'}, "l", "w")

-- Quick list move
vimp.nnoremap({'override'}, "<leader>p", ":cprevious<CR>")
vimp.nnoremap({'override'}, "<leader>n", ":cnext<CR>")

vimp.nnoremap({'override'}, "<C-s>", ":w<CR>")

-- Navigate pane
vimp.nnoremap({'override'}, "<C-j>", "<C-W>j")
vimp.nnoremap({'override'}, "<C-k>", "<C-W>k")
vimp.nnoremap({'override'}, "<C-h>", "<C-W>h")
vimp.nnoremap({'override'}, "<C-l>", "<C-W>l")
