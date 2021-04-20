require'dapui'.setup({
  icons = {
    expanded = "",
    collapsed = "",
    circular = "",
  },
  sidebar = {
    elements = {
      "scopes", "watches"
    }
  }
})

vim.fn.sign_define('DapBreakpoint', {
  text = "●",
  texthl = "WarningMsg",
})

require 'modules/debugging/adapters/go'

local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

mapper('n', '<F1>', '<cmd>lua require\'dap\'.disconnect()<CR>')
mapper('n', '<F5>', '<cmd>lua require\'dap\'.continue()<CR>')
mapper('n', '<F9>', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
mapper('n', '<F10>', '<cmd>lua require\'dap\'.step_over()<CR>')
mapper('n', '<F11>', '<cmd>lua require\'dap\'.step_into()<CR>')
mapper('n', '<F12>', '<cmd>lua require\'dap\'.step_out()<CR>')

require('dap.ext.vscode').load_launchjs()
