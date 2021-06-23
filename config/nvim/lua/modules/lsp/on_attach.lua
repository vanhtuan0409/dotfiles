-- LSP on attach
local _M = {}

function _M.default(client, bufnr)
  require'lsp-status'.on_attach(client, bufnr)
  require'lsp_signature'.on_attach({
    bind = false,
    use_lspsaga = true,
    hint_enable = false,
  })

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function command(...) vim.api.nvim_command(...) end

  command([[autocmd CursorHold  * :Lspsaga show_line_diagnostics]])
  -- command([[autocmd CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics()]])

  -- mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', [[:Lspsaga hover_doc<CR>]], opts)
  buf_set_keymap('n', 'gh', [[:Lspsaga lsp_finder<CR>]], opts)
  buf_set_keymap('n', '<leader>rn', [[:Lspsaga rename<CR>]], opts)
  buf_set_keymap('n', '<leader>ga', [[:Lspsaga code_action<CR>]], opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- auto format
  require'modules/lsp/utils'.auto_formatting(client)
end

function _M.non_format(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  _M.default(client, bufnr)
end

return _M
