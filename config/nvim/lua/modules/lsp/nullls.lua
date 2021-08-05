local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local installer = require'installer'

nullls.config({
  sources = {
    formatting.goimports.with({ command = installer.bin("goimports") }),
    formatting.rustfmt,
    formatting.black,
    formatting.deno_fmt,
    formatting.prettier.with({
      command = installer.bin("prettier"),
      filetypes = {"vue", "svelte", "css", "html", "json", "yaml", "markdown"},
    })
  }
})

require("lspconfig")["null-ls"].setup({
    on_attach = require'modules/lsp/on_attach'.default,
})
