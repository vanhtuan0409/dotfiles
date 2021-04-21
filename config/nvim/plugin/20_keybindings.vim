" ESC related keybinding
map <leader>a <Esc>ggVG<CR>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
imap jj <Esc>

" Smart home
noremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Toggle explorer
noremap <Space><Space> :Broot<CR>

" Binding j k to move by displayed line
nnoremap j gj
nnoremap k gk

" Leader related keybinding
" Quick save and close file
noremap <leader>p :cprevious<CR>
noremap <leader>n :cnext<CR>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<SPACE>
nnoremap <C-s> :w<CR>
nnoremap <C-d> :BufferClose<CR>
nnoremap <C-w> :silent :bufdo :BufferClose<CR>
" Navigate pane
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <Tab> :BufferNext<CR>
nnoremap <S-Tab> :BufferPrevious<CR>

if has('gui') || has('nvim')
  tnoremap <a-a> <esc>a
  tnoremap <a-b> <esc>b
  tnoremap <a-d> <esc>d
  tnoremap <a-f> <esc>f
endif
