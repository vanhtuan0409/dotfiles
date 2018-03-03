" Basic setup 
syntax on
set nocompatible
set encoding=utf-8

" Turn off backup
set nobackup
set nowb
set noswapfile

" Set auto read when a file is changed from the outside
set autoread

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
map 0 ^
imap jj <Esc>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Binding j k to move by displayed line
nnoremap j gj
nnoremap k gk

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

