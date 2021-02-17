local lspconfig = require'lspconfig'
local lsp_util = require'lspconfig/util'

require'lspsaga'.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  code_action_icon = ' ',
  finder_definition_icon = '* ',
  finder_reference_icon = '* ',
  finder_action_keys = {
    quit = '<Esc>'
  },
  code_action_keys = {
    quit = '<Esc>'
  },
  rename_action_keys = {
    quit = '<Esc>'
  }
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
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = false;
    tags = false;
    snippets_nvim = true;
    treesitter = true;
  };
}

-- Ref: https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/hover.lua#L28
-- Avoid overlapping popup
function ShowLineDiagnostics(...)
  if not require'lspsaga.hover'.has_saga_hover() then
    require'lspsaga.diagnostic'.show_line_diagnostics(...)
  end
end

-- Use Tab and S-Tab to cycle
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.api.nvim_set_keymap("i", "<C-Space>", [[compe#complete()]], {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm('<CR>')]], {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close('<C-e>')]], {expr = true, silent = true})

-- LSP on attach
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- auto show diagnostic
  vim.api.nvim_command([[autocmd CursorHold  * lua ShowLineDiagnostics({ show_header = false })]])

  -- mappings
  buf_set_keymap('n', 'K', [[:Lspsaga hover_doc<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', 'gh', [[:Lspsaga lsp_finder<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>rn', [[:Lspsaga rename<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>ga', [[:Lspsaga code_action<CR>]], { noremap=true, silent=true })

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap=true, silent=true })

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

-- customize diagnostic info
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    -- Hide virtual text
    virtual_text = false,
    -- Increase diagnostic signs priority
    signs = {
      priority = 9999,
    },
    update_in_insert = false,
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
      usePlaceholders = true,
      completeUnimported = true,
    }
  }
}

lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "/home/tuan/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer" },
}
