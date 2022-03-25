local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local code_actions = nullls.builtins.code_actions
local installer = require('installer')
local conditions = require('modules/nullls/conditions')
local goext = require('modules/nullls/go')

nullls.setup({
  default_timeout = 500,
  debouce = 250,
  on_attach = require'modules/lsp/on_attach'.make_on_attach(),
  sources = {
    formatting.gofumpt.with({
      command = installer.bin("gofumpt"),
      condition = conditions.is_shopee_path(false),
    }),
    formatting.gofmt.with({
      condition = conditions.is_shopee_path(true),
    }),
    formatting.rustfmt,
    formatting.black,
    formatting.prettierd.with({ command = installer.bin("prettierd") }),
    formatting.terraform_fmt,

    goext.code_actions.gostructhelper,
    goext.code_actions.gomodifytags,
  }
})
