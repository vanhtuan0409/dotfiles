local M = {}

function M.make_default()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  local conf = vim.tbl_extend(
    "force",
    require'lspconfig'.util.default_config,
    {
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  )
  return conf
end

function M.auto_formatting(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 200)
      augroup END
    ]]
  end
end

function M.auto_codelenses(client)
  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      command! CodeLensRun lua vim.lsp.codelens.run()
      command! CodeLensRefresh lua vim.lsp.codelens.refresh()

      highlight! link LspCodeLens AquaItalic
      highlight! link LspCodeLensSign AquaItalic
      highlight! link LspCodeLensSeparator Boolean

      augroup LspCodelens
        autocmd! * <buffer>
        autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]]
  end
end

return M
