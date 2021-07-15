local M = {}

function M.setup()
  local vimp = require("vimp")
  vimp.nnoremap({'override'}, '<F1>', '<cmd>lua require\'dap\'.disconnect()<CR>')
  vimp.nnoremap({'override'}, '<F5>', '<cmd>lua require\'dap\'.continue()<CR>')
  vimp.nnoremap({'override'}, '<F9>', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
  vimp.nnoremap({'override'}, '<F10>', '<cmd>lua require\'dap\'.step_over()<CR>')
  vimp.nnoremap({'override'}, '<F11>', '<cmd>lua require\'dap\'.step_into()<CR>')
  vimp.nnoremap({'override'}, '<F12>', '<cmd>lua require\'dap\'.step_out()<CR>')
end

function M.config()
  require 'modules/debugging/adapters/go'
  require('dap.ext.vscode').load_launchjs()
end

return M
