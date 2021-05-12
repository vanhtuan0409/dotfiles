local lspconfig = require'lspconfig'
local utils = require'modules/lsp/utils'
local attach = require'modules/lsp/on_attach'
local installer = require'modules/installer'
local efm_langs = require'modules/formatting'

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
lspconfig.util.default_config = utils.make_default_capabilities()

lspconfig.gopls.setup{
  cmd = { installer.bin("gopls") },
  on_attach = attach.non_format,
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
    }
  }
}

lspconfig.rust_analyzer.setup{
  cmd = { installer.bin("rust_analyzer") },
  on_attach = attach.non_format,
}

lspconfig.dartls.setup {
  on_attach = attach.non_format,
}

lspconfig.tsserver.setup{
  cmd = { installer.bin("tsserver"), "--stdio" },
  on_attach = attach.non_format,
}

lspconfig.efm.setup {
  cmd = { installer.bin("efm"), "-logfile", vim.fn.stdpath("data") .. "/efm.log" },
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
