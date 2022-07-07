local function organizeImport(client, bufnr)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }

  local result = client.request_sync("textDocument/codeAction", params, 200, bufnr) or {}
  for _, r in pairs(result.result or {}) do
    if r.edit then
      vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
    else
      vim.lsp.buf.execute_command(r.command)
    end
  end
end

return function(client, bufnr)
  local golsp_ag = vim.api.nvim_create_augroup("GoLsp", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = golsp_ag,
    buffer = bufnr,
    callback = function(params)
      organizeImport(client, bufnr)
    end,
  })
end
