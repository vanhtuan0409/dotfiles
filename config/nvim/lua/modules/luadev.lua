local attach = require'modules/lsp/on_attach'
local installer = require'installer'

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = { installer.bin("lua-language-server") },
    on_attach = attach.make_on_attach({ document_formatting = false }),
  },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
