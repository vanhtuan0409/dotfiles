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
