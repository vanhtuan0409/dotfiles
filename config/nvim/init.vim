" Automatically install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin("~/.local/share/nvim/site/plugged")
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'sainnhe/gruvbox-material'
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
Plug 'chr4/nginx.vim'
Plug 'hashivim/vim-terraform'
Plug 'haya14busa/incsearch.vim'
Plug 'robbles/logstash.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'wakatime/vim-wakatime'

Plug 'nvim-lua/plenary.nvim'

Plug 'hoob3rt/lualine.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

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
