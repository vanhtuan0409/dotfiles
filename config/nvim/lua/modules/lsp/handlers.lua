-- customize lsp handlers
local popup_opts = {
  border = "rounded",
  focusable = false,
  close_events = {
    "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", -- default
    "BufLeave",
  },
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = {
      priority = 999,
    },
    update_in_insert = false,
  }
)
local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
  -- supress NULL_LS error msg
  if err and vim.startswith(err.message, "NULL_LS") then
    return
  end
  return default_exe_handler(err, result, ctx, config)
end
