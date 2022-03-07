local M = {}

function M.setup()
  local vimp = require("vimp")
  vimp.nnoremap('<F1>', '<cmd>lua DapClose()<CR>')
  vimp.nnoremap('<F2>', '<cmd>lua require"dap.breakpoints".clear()<CR>')
  vimp.nnoremap('<F5>', '<cmd>lua require"dap".continue()<CR>')
  vimp.nnoremap('<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
  vimp.nnoremap('<F10>', '<cmd>lua require"dap".step_over()<CR>')
  vimp.nnoremap('<F11>', '<cmd>lua require"dap".step_into()<CR>')
  vimp.nnoremap('<F12>', '<cmd>lua require"dap".step_out()<CR>')
end

function M.config()
  require 'modules/debugging/adapters/go'
  require 'modules/debugging/adapters/scala'
  require('dap.ext.vscode').load_launchjs()
end

function DapClose()
  require'dap'.disconnect()
  require'dap'.repl.close()
  local dapui = require("utils").prequire("dapui")
  if dapui then
    dapui.close()
  end
end

return M
