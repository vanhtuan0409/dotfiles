local augroup = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })

return function(client, bufnr)
  local diagnostic_method = "textDocument/publishDiagnostics"
  if client.supports_method(diagnostic_method) then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = augroup,
      buffer = bufnr,
      callback = function(params)
        vim.diagnostic.open_float(nil)
      end,
    })
  end
end
