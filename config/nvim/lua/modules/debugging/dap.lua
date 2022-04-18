local M = {}

local DapClose = function()
  require'dap'.disconnect()
  require'dap'.repl.close()
  local dapui = require("utils").prequire("dapui")
  if dapui then
    dapui.close()
  end
end

function M.setup()
  vim.keymap.set('n', '<F1>', DapClose)
  vim.keymap.set('n', '<F2>', '<cmd>lua require"dap.breakpoints".clear()<CR>')
  vim.keymap.set('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
  vim.keymap.set('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
  vim.keymap.set('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>')
  vim.keymap.set('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')
  vim.keymap.set('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')
end

function M.config()
  require 'modules/debugging/adapters/go'
  require 'modules/debugging/adapters/scala'

  local vscode_ext = require('dap.ext.vscode')
  local ok, _ = pcall(vscode_ext.load_launchjs)
  if not ok then
    vim.api.nvim_echo({{"Nvim DAP unable to load vscode extension", "WarningMsg"}}, true, {})
  end
end

return M
