set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

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
Plug 'junegunn/fzf.vim', { 'commit': '0fe8e198a3a501b54dbc4f9587526c097599f95a' }
Plug 'schickling/vim-bufonly'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chr4/nginx.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'robbles/logstash.vim'
Plug 'mcchrish/nnn.vim'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

source $HOME/.vimrc
