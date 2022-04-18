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
    local formatting_ag = vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_ag,
      buffer = 0,
      callback = function(params)
        vim.lsp.buf.formatting_seq_sync(nil, 200)
      end,
    })
  end
end

function M.auto_codelenses(client)
  if client.resolved_capabilities.code_lens then
    vim.api.nvim_create_user_command("CodeLensRun", function(params)
      vim.lsp.codelens.run()
    end, { bang = true })
    vim.api.nvim_create_user_command("CodeLensRefresh", function(params)
      vim.lsp.codelens.refresh()
    end, { bang = true })

    local codelens_ag = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = codelens_ag,
      buffer = 0,
      callback = function(params)
        vim.lsp.codelens.refresh()
      end,
    })
  end
end

return M
