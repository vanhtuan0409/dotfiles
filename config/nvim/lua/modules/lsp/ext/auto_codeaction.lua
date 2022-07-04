return function(client, bufnr)
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
