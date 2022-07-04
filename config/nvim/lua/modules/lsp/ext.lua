local _M = {}

function _M.goimports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

function _M.jsonStatus(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { uri = "" }

  local result = vim.lsp.buf_request_sync(0, "json/languageStatus", params, timeout_ms)
  print(vim.inspect(result))
end

return _M
