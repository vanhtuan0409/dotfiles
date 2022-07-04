local M = {}

function doFormat(client, bufnr)
  -- For future use
  -- Whenever this PR is released: https://github.com/neovim/neovim/pull/18193
  --
  -- vim.lsp.buf.format({
  --   timeout_ms = 200,
  --   bufnr = bufnr,
  --   name = client.name,
  -- })
  --
  vim.lsp.buf.formatting_seq_sync(nil, 200)
end

function M.on_attach(client, bufnr)
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

return M
