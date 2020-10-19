" Auto reload file changes
autocmd CursorHold * checktime
autocmd FocusGained,BufEnter * :checktime

" Dont regconize quickfix list as buffer
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END
