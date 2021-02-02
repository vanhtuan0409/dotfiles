local lspconfig = require'lspconfig'
local lsp_util = require'lspconfig/util'

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local on_attach = function(client, bufnr)
  local options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  vim.api.nvim_set_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
  vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
  vim.api.nvim_set_keymap('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)

  vim.api.nvim_command([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
  vim.api.nvim_command([[autocmd CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })]])

  -- auto format
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- remove default format of lang server
local on_attach_no_format = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  on_attach(client)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- Hide virtual text
    virtual_text = false,
    -- Increase diagnostic signs priority
    signs = {
      priority = 9999,
    },
    update_in_insert = true,
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "/home/tuan/.config/coc/extensions/coc-go-data/bin/gopls" },
  settings = {
    gopls = {
      completeUnimported = true,
    }
  }
}

lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "/home/tuan/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer" },
}
