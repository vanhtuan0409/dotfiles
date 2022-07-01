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

function M.auto_formatting(client, bufnr)
  local fmt_method = "textDocument/formatting"
  if client.supports_method(fmt_method) then
    local formatting_ag = vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_ag,
      buffer = bufnr,
      callback = function(...)
        -- For future use
        -- Whenever this PR is released: https://github.com/neovim/neovim/pull/18193
        --
        -- vim.lsp.buf.format({
        --   timeout_ms = 200,
        --   bufnr = bufnr,
        --   name = client.name,
        -- })

        local params = vim.lsp.util.make_formatting_params({})
        local result, err = client.request_sync(fmt_method, params, 200, bufnr)
        if result and result.result then
          vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
        elseif err then
          vim.notify('auto_formatting: ' .. err, vim.log.levels.WARN)
        end
      end,
    })
  end
end

function M.auto_codelenses(client, bufnr)
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

function M.auto_codeaction(client, bufnr)
  local codeaction_method = "textDocument/codeAction"
  if client.supports_method(codeaction_method) then
    local lightbulb = require('nvim-lightbulb')
    local codeaction_ag = vim.api.nvim_create_augroup("LspCodeAction", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = codeaction_ag,
      buffer = bufnr,
      callback = function(params)
        lightbulb.update_lightbulb()
      end,
    })
  end
end

return M
