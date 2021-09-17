local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local code_actions = nullls.builtins.code_actions
local my_code_actions = require('modules/nullls/code_actions')
local installer = require('installer')
local conditions = require('modules/nullls/conditions')

nullls.config({
  default_timeout = 500,
  debouce = 250,
  sources = {
    -- formatting.goimports.with({ command = installer.bin("goimports") }),
    formatting.gofumpt.with({
      command = installer.bin("gofumpt"),
      condition = conditions.is_shopee_path(false),
    }),
    formatting.gofmt.with({
      condition = conditions.is_shopee_path(true),
    }),
    formatting.rustfmt,
    formatting.black,
    formatting.deno_fmt.with({
      args = {"fmt", "--ext", "$FILEEXT", "-"},
      filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "json"}
    }),
    formatting.prettier.with({
      command = installer.bin("prettier"),
      filetypes = {"vue", "svelte", "css", "html", "yaml", "markdown"},
    }),

    code_actions.gitsigns,
    my_code_actions.gostructhelper,
  }
})

require("lspconfig")["null-ls"].setup({
  on_attach = require'modules/lsp/on_attach'.default,
})
