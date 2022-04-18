vim.keymap.set("n", "<leader>a", "<Esc>ggVG<CR>")
vim.keymap.set("n", "<leader>l", ":noh<CR>")
vim.keymap.set("n", "<S-Enter>", "O<Esc>")
vim.keymap.set("n", "<CR>", "o<Esc>")
vim.keymap.set("i", "jj", "<Esc>")

-- Quickly goback
vim.keymap.set("n", "<BS>", "<C-o>")

-- Smart home
vim.keymap.set("n", "0", [[col('.') == match(getline('.'),'\S')+1 ? '0' : '^']], { expr = true, silent = true })

-- Smart move around
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Quick list move
vim.keymap.set("n", "<leader>p", ":cprevious<CR>")
vim.keymap.set("n", "<leader>n", ":cnext<CR>")

vim.keymap.set("n", "<C-s>", ":w<CR>")

-- Navigate pane
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l") -- override default nvim mapping to <C-l>
