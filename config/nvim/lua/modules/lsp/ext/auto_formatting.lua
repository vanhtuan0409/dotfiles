function doFormat(client, bufnr)
  vim.lsp.buf.format({
    timeout_ms = 200,
    bufnr = bufnr,
    name = client.name,
  })
end

return function(client, bufnr)
  local fmt_method = "textDocument/formatting"
  if client.supports_method(fmt_method) then
    vim.api.nvim_create_user_command("Formatting", function(params)
      doFormat(client, bufnr)
    end, { bang = true })

    local formatting_ag = vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_ag,
      buffer = bufnr,
      callback = function(...)
        doFormat(client, bufnr)
      end,
    })
  end
end
