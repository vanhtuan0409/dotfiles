require("globals")
require("options")
require("plugins")
require("keybindings")

vim.cmd [[
  " Auto reload file changes
  autocmd FocusGained,BufEnter * :checktime

  " Dont regconize quickfix list as buffer
  augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
  augroup END
]]
