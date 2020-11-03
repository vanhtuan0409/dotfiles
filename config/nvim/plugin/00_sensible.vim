" Basic setup
syntax on
set nocompatible
set noshowmode
set encoding=utf-8
set showcmd
set lazyredraw
set mouse=a
set magic
if filereadable("/bin/zsh")
  set shell=/bin/zsh
endif

" Config for coc.nvim
set updatetime=100
set shortmess+=c
set signcolumn=yes

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

set cursorline
set scrolloff=999

" Set ignore case when search
set ignorecase
set infercase
set smartcase

" Set line number to hybrid mode
set number
set relativenumber

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

set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" Set true color
if (has("termguicolors"))
  set termguicolors
endif

" GUI Setting
if has('gui_running')
  set guioptions-=e  "remove tab bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif
