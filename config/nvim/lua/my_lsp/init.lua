if vim.g.lsp_mode ~= "lsp" then
  return
end

local lspconfig = require'lspconfig'
local attach = require'my_lsp/on_attach'

require'my_lsp/plugins/saga'
require'my_lsp/plugins/compe'
require'my_lsp/plugins/status'

-- customize diagnostic info
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    -- Hide virtual text
    virtual_text = false,
    -- Increase diagnostic signs priority
    signs = {
      priority = 999,
    },
    update_in_insert = false,
  }
)

-- Set snippet support and status line compatibilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- set vsnip support
capabilities = vim.tbl_extend('keep', capabilities, require'lsp-status'.capabilities)
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities
  }
)

lspconfig.gopls.setup{
  on_attach = attach.non_format,
  cmd = { "/home/tuan/.config/coc/extensions/coc-go-data/bin/gopls" },
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
    }
  }
}

lspconfig.rust_analyzer.setup{
  on_attach = attach.non_format,
  cmd = { "/home/tuan/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer" },
}

lspconfig.dartls.setup {
  on_attach = attach.non_format,
}

local efm_langs = require'my_lsp/plugins/efm'
lspconfig.efm.setup {
  init_options = {
    documentFormatting = true
  },
  on_attach = attach.default,
  filetypes = vim.tbl_keys(efm_langs),
  -- attach to all files but filter by filetypes
  root_dir = lspconfig.util.root_pattern("."),
  settings = {
    languages = efm_langs,
  }
}
