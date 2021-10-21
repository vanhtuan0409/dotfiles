local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
  icons = {
    expanded = "",
    collapsed = "",
    circular = "",
  },
  sidebar = {
    elements = {
      { id = "scopes", size = 0.5 },
      { id = "watches", size = 0.5 },
    }
  }
})

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {
  text = "●",
  texthl = "WarningMsg",
})
