local lspconfig = require'lspconfig'
local lsp_util = require'lspconfig/util'

require'lspsaga'.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
}

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

-- Ref: https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/hover.lua#L28
local function has_saga_hover()
  local has_hover_win,datas = pcall(vim.api.nvim_win_get_var,0,'lspsaga_hoverwin_data')
  if not has_hover_win then return false end
  if vim.api.nvim_win_is_valid(datas[1]) then
    return true
  end
  return false
end

function ShowLineDiagnostics(...)
  if not has_saga_hover() then
    require'lspsaga.diagnostic'.show_line_diagnostics(...)
  end
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- auto show diagnostic
  vim.api.nvim_command([[autocmd CursorHold  * lua ShowLineDiagnostics({ show_header = false })]])

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
