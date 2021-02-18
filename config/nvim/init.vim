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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chr4/nginx.vim'
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
lua require("my_lsp")

" Map leader
let mapleader="\<Space>"

" Themes
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material

" closetag plugin
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Broot
command! -nargs=? -complete=command BrootCurrentDirectory   call broot#OpenBrootIn("%:p:h", 'edit')
command! -nargs=? -complete=command BrootWorkingDirectory   call broot#OpenBrootIn(".", 'edit')
command! -nargs=? -complete=command Broot                   BrootCurrentDirectory

set foldmethod=expr
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
