local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local installer = require('installer')
local conditions = require('modules/nullls/conditions')
local goext = require('modules/nullls/go')

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

    nullls.builtins.code_actions.gitsigns,
    goext.code_actions.gostructhelper,
    goext.code_actions.gomodifytags,
  }
})

require("lspconfig")["null-ls"].setup({
  on_attach = require'modules/lsp/on_attach'.make_on_attach(),
})
