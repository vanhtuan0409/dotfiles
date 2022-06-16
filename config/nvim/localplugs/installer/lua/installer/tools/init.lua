local tools = {
  [ "gopls" ] = require'installer.tools.gopls',
  [ "goimports" ] = require'installer.tools.goimports',
  [ "gofumpt" ] = require'installer.tools.gofumpt',
  [ "gomodifytags" ] = require'installer.tools.gomodifytags',
  [ "goimpl" ] = require'installer.tools.goimpl',
  [ "gostructhelper" ] = require'installer.tools.gostructhelper',
  [ "rust_analyzer" ] = require'installer.tools.rust_analyzer',
  [ "efm" ] = require'installer.tools.efm',
  [ "tsserver" ] = require'installer.tools.tsserver',
  [ "prettier" ] = require'installer.tools.prettier',
  [ "prettierd" ] = require'installer.tools.prettierd',
  [ "vscode_go" ] = require'installer.tools.vscode_go',
  [ "pyright" ] = require'installer.tools.pyright',
  [ "dlv" ] = require'installer.tools.dlv',
  [ "black" ] = require'installer.tools.black',
  [ "lua-language-server" ] = require'installer.tools.lua_language_server',
  [ "terraform-ls" ] = require'installer.tools.terraform_ls',
}

return tools
