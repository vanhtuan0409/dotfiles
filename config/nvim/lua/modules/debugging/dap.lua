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
  require("utils").keymap_set_multi("n", {
    ["<F1>"]  = DapClose,
    ["<F2>"]  = function() require"dap.breakpoints".clear() end,
    ["<F5>"]  = function() require"dap".continue() end,
    ["<F9>"]  = function() require"dap".toggle_breakpoint() end,
    ["<F10>"] = function() require"dap".step_over() end,
    ["<F11>"] = function() require"dap".step_into() end,
    ["<F12>"] = function() require"dap".step_out() end,
  })
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
