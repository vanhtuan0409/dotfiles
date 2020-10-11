call plug#begin()
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
Plug 'wfxr/minimap.vim'
call plug#end()

" Themes
set background=dark
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material

" Patch nnn color
let g:terminal_color_4 = '#83a598'

let g:nnn#set_default_mappings = 0
let g:nnn#command = "PAGER=less NNN_OPTS=\"\" nnn -ecHx"

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" Auto start minimap
let g:minimap_auto_start = 1

" Lightline config
set laststatus=2
set showtabline=2

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'tabline': {
  \   'left': [['buffers']],
  \ },
  \ 'active': {
  \   'left': [['mode', 'paste']],
  \   'right': [['lineinfo'],
  \             ['percent'],
  \             ['cocstatus'],
  \             ['filetype']],
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \ },
  \ }

" FZF
let g:fzf_layout = { 'window': 'call FzfFloatingWindow()' }
function! FzfFloatingWindow()
  let height = float2nr((&lines - 2) * 0.6) " lightline + status
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction
