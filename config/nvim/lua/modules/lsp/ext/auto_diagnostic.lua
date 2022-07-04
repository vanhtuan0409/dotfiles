local M = {}

function M.on_attach(client, bufnr)
  local diagnostic_method = "textDocument/publishDiagnostics"
  if client.supports_method(diagnostic_method) then
    local diagnostic_ag = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = diagnostic_ag,
      buffer = bufnr,
      callback = function(params)
        vim.diagnostic.open_float(nil, {
          source='always',
          border='single',
          focusable=false,
        })
      end,
    })
  end
end

return M
