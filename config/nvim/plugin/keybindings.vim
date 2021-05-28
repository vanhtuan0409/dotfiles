" ESC related keybinding
map <leader>a <Esc>ggVG<CR>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
imap jj <Esc>

" Smart home
noremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

" Binding j k to move by displayed line
nnoremap j gj
nnoremap k gk

" Binding h l to move faster
nnoremap h b
nnoremap l w

" Leader related keybinding
" Quick save and close file
noremap <leader>p :cprevious<CR>
noremap <leader>n :cnext<CR>
nnoremap <C-s> :w<CR>

" Navigate pane
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

if has('gui') || has('nvim')
  tnoremap <a-a> <esc>a
  tnoremap <a-b> <esc>b
  tnoremap <a-d> <esc>d
  tnoremap <a-f> <esc>f
endif
