local nullls = require("null-ls")
local formatting = nullls.builtins.formatting
local code_actions = nullls.builtins.code_actions
local installer = require'installer'

local is_shopee_path = function(utils)
  if not SHOPEE_PATH then
    return false
  end
  return utils.root_matches(SHOPEE_PATH)
end

nullls.config({
  default_timeout = 500,
  debouce = 250,
  sources = {
    -- formatting.goimports.with({ command = installer.bin("goimports") }),
    formatting.gofumpt.with({
      command = installer.bin("gofumpt"),
      condition = function(utils)
        return not is_shopee_path(utils)
      end,
    }),
    formatting.gofmt.with({
      condition = function(utils)
        return is_shopee_path(utils)
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
    }),

    code_actions.gitsigns,
  }
})

require("lspconfig")["null-ls"].setup({
  on_attach = require'modules/lsp/on_attach'.default,
})
