local augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })

local function doFormat(client, bufnr)
  vim.lsp.buf.format({
    timeout_ms = 200,
    bufnr = bufnr,
    filter = function(it)
      return it.name == client.name
    end,
  })
end

return function(client, bufnr)
  local fmt_method = "textDocument/formatting"
  if client.supports_method(fmt_method) then
    vim.api.nvim_create_user_command("Formatting", function(params)
      doFormat(client, bufnr)
    end, { bang = true })

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function(...)
        doFormat(client, bufnr)
      end,
    })
  end
end
