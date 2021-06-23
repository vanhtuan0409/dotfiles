local tools = {
  [ "gopls" ] = require'installer/tools/gopls',
  [ "goimports" ] = require'installer/tools/goimports',
  [ "rust_analyzer" ] = require'installer/tools/rust_analyzer',
  [ "efm" ] = require'installer/tools/efm',
  [ "tsserver" ] = require'installer/tools/tsserver',
  [ "prettier" ] = require'installer/tools/prettier',
  [ "vscode_go" ] = require'installer/tools/vscode_go',
  [ "pyright" ] = require'installer/tools/pyright',
}

return tools
