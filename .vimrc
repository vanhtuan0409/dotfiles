" Basic setup
syntax on
set nocompatible
set noshowmode
set encoding=utf-8
set showcmd
set lazyredraw
set mouse=a
if filereadable("/bin/zsh")
  set shell=/bin/zsh
endif

" Turn off backup
set nobackup
set nowritebackup
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
set infercase
set smartcase

" Set line number to hybrid mode
set nonumber
set norelativenumber

" Set ESC timeout
set timeoutlen=1000 ttimeoutlen=0

" Allow copy to clipboard
if has("mac")
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
endif

" No annoying sound on errors
set noerrorbells
set novisualbell

" Allow backspace for anything in insert mode
set backspace=indent,eol,start

" Hide preview window when autocomplete
set completeopt-=preview

" Set tab value
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
filetype plugin indent on

" Indenting
set autoindent
set smartindent

" Set buffer hidden
set hidden

" GUI Setting
if has('gui_running')
  set guioptions-=e  "remove tab bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

" Strip trailing white space
autocmd BufWritePre * :%s/\s\+$//e

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

" Dont regconize quickfix list as buffer
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

