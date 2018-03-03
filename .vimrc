" Basic setup 
syntax on
set nocompatible
set encoding=utf-8
set noswapfile
set ignorecase
set smartcase
set nowrap

" Set line number to hybrid mode
set number
set relativenumber
set numberwidth=3

" Allow copy to clipboard
set clipboard=unnamed

" Hide preview window when autocomplete
set completeopt-=preview

" Set tab value
set expandtab
set softtabstop=4
set shiftwidth=4
filetype plugin indent on

" Indenting
set autoindent
set smartindent

" Keymap section
imap jj <Esc>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins from bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

