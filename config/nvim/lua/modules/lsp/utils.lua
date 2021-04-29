local M = {}

function M.make_default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true -- set vsnip support
  capabilities = vim.tbl_extend('keep', capabilities, require'lsp-status'.capabilities)
  capabilities = vim.tbl_extend(
    "force",
    require'lspconfig'.util.default_config,
    {
      capabilities = capabilities
    }
  )
  return capabilities
end

function M.auto_formatting(client)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup Format
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]], false)
  end
end

return M
