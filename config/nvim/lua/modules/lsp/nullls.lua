local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local installer = require'installer'

nullls.config({
  default_timeout = 3000,
  sources = {
    -- formatting.goimports.with({ command = installer.bin("goimports") }),
    formatting.gofumpt.with({
      command = installer.bin("gofumpt"),
      condition = function(utils)
        return not utils.root_matches(SHOPEE_PATH)
      end,
    }),
    formatting.gofmt.with({
      condition = function(utils)
        return utils.root_matches(SHOPEE_PATH)
      end,
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
    })
  }
})

require("lspconfig")["null-ls"].setup({
    on_attach = require'modules/lsp/on_attach'.default,
})
