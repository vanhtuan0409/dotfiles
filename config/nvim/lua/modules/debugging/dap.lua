require 'modules/debugging/adapters/go'

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<F1>', '<cmd>lua require\'dap\'.disconnect()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require\'dap\'.continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require\'dap\'.step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require\'dap\'.step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require\'dap\'.step_out()<CR>', opts)

require('dap.ext.vscode').load_launchjs()
