local tools = {
  [ "gopls" ]  = require'modules/installer/tools/gopls',
  [ "goimports" ]  = require'modules/installer/tools/goimports',
  [ "rust_analyzer" ]  = require'modules/installer/tools/rust_analyzer',
  [ "efm" ]  = require'modules/installer/tools/efm',
  [ "tsserver" ]  = require'modules/installer/tools/tsserver',
  [ "prettier" ]  = require'modules/installer/tools/prettier',
  [ "vscode_go" ]  = require'modules/installer/tools/vscode_go',
}

return tools
