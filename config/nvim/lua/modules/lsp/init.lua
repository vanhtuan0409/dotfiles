local lspconfig = require'lspconfig'
local utils = require'modules/lsp/utils'
local attach = require'modules/lsp/on_attach'
local installer = require'installer'
require'modules/lsp/code_lens'

-- customize lsp handlers
local popup_opts = {
  border = "rounded",
  focusable = false,
  close_events = {
    "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", -- default
    "BufLeave",
  },
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = {
      priority = 999,
    },
    update_in_insert = false,
  }
)
local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
  -- supress NULL_LS error msg
  if err and vim.startswith(err.message, "NULL_LS") then
    return
  end
  return default_exe_handler(err, result, ctx, config)
end

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
