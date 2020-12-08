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
Plug 'haya14busa/incsearch.vim'
Plug 'robbles/logstash.vim'
Plug 'mcchrish/nnn.vim'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

lua require("my_treesitter")

" Map leader
let mapleader="\<Space>"

" Themes
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material

" nnn plugin
let g:terminal_color_4 = '#83a598'
let g:nnn#set_default_mappings = 0
let g:nnn#command = "PAGER=less NNN_OPTS=\"\" nnn -ecHx"

" closetag plugin
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

set foldmethod=expr
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
