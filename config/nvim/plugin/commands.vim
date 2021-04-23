" Broot
command! -nargs=? -complete=command BrootCurrentDirectory   call broot#OpenBrootIn("%:p:h", 'edit')
command! -nargs=? -complete=command BrootWorkingDirectory   call broot#OpenBrootIn(".", 'edit')
command! -nargs=? -complete=command Broot                   BrootCurrentDirectory

" Auto reload file changes
autocmd FocusGained,BufEnter * :checktime

" Dont regconize quickfix list as buffer
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END
