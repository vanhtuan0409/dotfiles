local attach = require'modules/lsp/on_attach'
local installer = require'installer'

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = { installer.bin("lua-language-server") },
    on_attach = attach.make_on_attach(),
  },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
