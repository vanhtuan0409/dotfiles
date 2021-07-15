require 'modules/debugging/adapters/go'
local vimp = require("vimp")
vimp.nnoremap('<F1>', '<cmd>lua require\'dap\'.disconnect()<CR>')
vimp.nnoremap('<F5>', '<cmd>lua require\'dap\'.continue()<CR>')
vimp.nnoremap('<F9>', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
vimp.nnoremap('<F10>', '<cmd>lua require\'dap\'.step_over()<CR>')
vimp.nnoremap('<F11>', '<cmd>lua require\'dap\'.step_into()<CR>')
vimp.nnoremap('<F12>', '<cmd>lua require\'dap\'.step_out()<CR>')

require('dap.ext.vscode').load_launchjs()
