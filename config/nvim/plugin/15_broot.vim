" Broot
command! -nargs=? -complete=command BrootCurrentDirectory   call broot#OpenBrootIn("%:p:h", 'edit')
command! -nargs=? -complete=command BrootWorkingDirectory   call broot#OpenBrootIn(".", 'edit')
command! -nargs=? -complete=command Broot                   BrootCurrentDirectory
