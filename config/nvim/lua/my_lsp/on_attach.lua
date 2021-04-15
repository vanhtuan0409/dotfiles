-- LSP on attach
local _M = {}

function _M.default(client, bufnr)
  require'lsp-status'.on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function command(...) vim.api.nvim_command(...) end

  -- command([[autocmd CursorHold  * lua require'lspsaga.diagnostic'.show_line_diagnostics()]])
  command([[autocmd CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics()]])

  -- mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', [[:Lspsaga hover_doc<CR>]], opts)
  buf_set_keymap('n', 'gh', [[:Lspsaga lsp_finder<CR>]], opts)
  buf_set_keymap('n', '<leader>rn', [[:Lspsaga rename<CR>]], opts)
  buf_set_keymap('n', '<leader>ga', [[:Lspsaga code_action<CR>]], opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- auto format
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup Format
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
      augroup END
    ]], false)
  end
end

function _M.non_format(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  _M.default(client, bufnr)
end

return _M
