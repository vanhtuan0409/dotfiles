" Automatically install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin("~/.local/share/nvim/site/plugged")
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'sainnhe/gruvbox-material'
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chr4/nginx.vim'
Plug 'hashivim/vim-terraform'
Plug 'haya14busa/incsearch.vim'
Plug 'robbles/logstash.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

lua require("my_treesitter")

" Map leader
let mapleader="\<Space>"

" Choose between `lsp` or `coc`
let g:lsp_mode = "lsp"
if g:lsp_mode == "lsp"
  lua require("my_lsp")
endif

set foldmethod=expr
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
