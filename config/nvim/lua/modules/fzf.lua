local opt = { noremap = true }
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', opt)
