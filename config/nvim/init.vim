lua require("main")
lua << EOF
require("modules/installer").setup{
  ensure = { 
   "gopls", "rust_analyzer", "efm", "tsserver",
   "prettier", "goimports",
   "vscode_go",
  }
}
EOF

" Map leader
let mapleader="\<Space>"

set foldmethod=expr
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
