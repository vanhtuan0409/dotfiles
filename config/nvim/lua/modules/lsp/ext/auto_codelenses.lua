return function(client, bufnr)
  local codelens_method = "textDocument/codeLens"
  if client.supports_method(codelens_method) then
    vim.api.nvim_create_user_command("CodeLensRun", function(params)
      vim.lsp.codelens.run()
    end, { bang = true })
    vim.api.nvim_create_user_command("CodeLensRefresh", function(params)
      vim.lsp.codelens.refresh()
    end, { bang = true })

    local codelens_ag = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = codelens_ag,
      buffer = bufnr,
      callback = function(params)
        vim.lsp.codelens.refresh()
      end,
    })
  end
end
