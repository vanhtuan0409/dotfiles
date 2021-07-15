-- LSP on attach
local _M = {}

function set_buf_keymap(bufnr)
  vim.cmd [[autocmd CursorHold  * :Lspsaga show_line_diagnostics]]
  -- vim.cmd [[autocmd CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics()]]

  local vimp = require("vimp")
  vimp.add_buffer_maps(bufnr, function()
    vimp.nnoremap({'override', 'silent'}, 'K', [[:Lspsaga hover_doc<CR>]])
    vimp.nnoremap({'override', 'silent'}, 'gh', [[:Lspsaga lsp_finder<CR>]])
    vimp.nnoremap({'override', 'silent'}, '<leader>rn', [[:Lspsaga rename<CR>]])
    vimp.nnoremap({'override', 'silent'}, '<leader>ga', [[:Lspsaga code_action<CR>]])
    vimp.nnoremap({'override', 'silent'}, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  end)
end

function _M.default(client, bufnr)
  require'lsp-status'.on_attach(client, bufnr)
  require'lsp_signature'.on_attach({
    bind = false,
    use_lspsaga = true,
    hint_enable = false,
  })

  if not vim.b.lsp_keymap then
    set_buf_keymap(bufnr)
    vim.b.lsp_keymap = true
  end

  -- auto format
  require'modules/lsp/utils'.auto_formatting(client)

  -- Emit user event
  vim.cmd [[ doautocmd User LspAttached ]]
end

function _M.non_format(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  _M.default(client, bufnr)
end

return _M
