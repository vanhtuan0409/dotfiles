local lspconfig = require'lspconfig'
local utils = require'modules/lsp/utils'
local attach = require'modules/lsp/on_attach'
local installer = require'installer'
require'modules/lsp/handlers'

-- Set snippet support and status line compatibilities
lspconfig.util.default_config = utils.make_default()

lspconfig.gopls.setup{
  cmd = { installer.bin("gopls") },
  on_attach = attach.make_on_attach({ document_formatting = false }),
  settings = {
    gopls = {
      usePlaceholders = false,
      completeUnimported = true,
      codelenses = {
        test  = true,
      },
    }
  }
}

lspconfig.rust_analyzer.setup{
  cmd = { installer.bin("rust_analyzer") },
  on_attach = attach.make_on_attach({ document_formatting = false }),
}

lspconfig.dartls.setup {
  on_attach = attach.make_on_attach({ document_formatting = false }),
}

lspconfig.tsserver.setup{
  cmd = { installer.bin("tsserver"), "--stdio" },
  on_attach = attach.make_on_attach({ document_formatting = false }),
}

lspconfig.pyright.setup{
  cmd = { installer.bin("pyright"), "--stdio" },
  on_attach = attach.make_on_attach({ document_formatting = false }),
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

vim.fn.setenv("JDTLS_HOME", installer.dir("jdtls"))
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
vim.fn.setenv("WORKSPACE", vim.fn.expand("$HOME/jdtls_workspace") .. "/" .. project_name)
lspconfig.jdtls.setup{
  on_attach = attach.make_on_attach({ document_formatting = false }),
}
