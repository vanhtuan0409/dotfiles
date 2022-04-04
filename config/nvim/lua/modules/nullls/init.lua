local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local code_actions = nullls.builtins.code_actions
local installer = require('installer')
local conditions = require('modules/nullls/conditions')
local goext = require('modules/nullls/go')

vim.cmd [[command! -nargs=1 NullLsToggle lua require("null-ls").toggle(<f-args>)]]

nullls.setup({
  default_timeout = 500,
  debouce = 250,
  on_attach = require'modules/lsp/on_attach'.make_on_attach(),
  should_attach = function(bufnr)
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    local blacklist = {}
    if vim.tbl_contains(blacklist, ft) then
      return false
    end
    return true
  end,
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
    formatting.trim_newlines,
    formatting.trim_whitespace,

    goext.code_actions.gostructhelper,
    goext.code_actions.gomodifytags,
  }
})
