local lspconfig = require'lspconfig'
local utils = require'modules/lsp/utils'
local attach = require'modules/lsp/on_attach'
local installer = require'installer'
local efm_langs = require'modules/formatting/efm'

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
lspconfig.util.default_config = utils.make_default()

lspconfig.gopls.setup{
  cmd = { installer.bin("gopls") },
  on_attach = attach.non_format,
  settings = {
    gopls = {
      usePlaceholders = false,
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

lspconfig.pyright.setup{
  cmd = { installer.bin("pyright"), "--stdio" },
  on_attach = attach.non_format,
  settings = {
    python = {
      pythonPath = vim.fn.exepath("python"),
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      }
    }
  },
}

lspconfig.efm.setup {
  cmd = { installer.bin("efm"), "-logfile", vim.fn.stdpath("data") .. "/efm.log" },
  init_options = {
    documentFormatting = true,
    hover = false,
    documentSymbol = false,
    codeAction = false,
    completion = false,
  },
  on_attach = attach.default,
  filetypes = vim.tbl_keys(efm_langs),
  settings = {
    languages = efm_langs,
  }
}
