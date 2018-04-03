" Basic setup
syntax on
set nocompatible
set encoding=utf-8
set showcmd
set lazyredraw
set mouse=a

" Turn off backup
set nobackup
set nowb
set noswapfile

" Set auto read and write when a file is changed from the outside
set autoread
set autowrite

" Set highlight search result and auto move cursor to matches
set hlsearch
set incsearch

" Set ignore case when search
set ignorecase
set smartcase

" Set line number to hybrid mode
set number
set relativenumber
set numberwidth=3

" Allow copy to clipboard
set clipboard=unnamed

" No annoying sound on errors
set noerrorbells
set novisualbell

" Allow backspace for anything in insert mode
set backspace=indent,eol,start

" Hide preview window when autocomplete
set completeopt-=preview

" Set tab value
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
filetype plugin indent on

" Indenting
set autoindent
set smartindent

" Strip trailing white space
autocmd BufWritePre * :%s/\s\+$//e

" Indenting for javascript
autocmd filetype javascript set sw=2 ts=2 sts=2

" Install keybindings
if filereadable(expand("~/.vimrc.keybindings"))
    source ~/.vimrc.keybindings
endif

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

