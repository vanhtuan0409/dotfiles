require("globals")
require("options")
require("plugins")
require("keybindings")

function big_file_disable()
  vim.cmd [[
    filetype off

    setlocal syntax=off
    setlocal foldmethod=manual
    setlocal noloadplugins
  ]]

  vim.api.nvim_buf_set_var(0, 'bigfile', true)
end

vim.cmd [[
  " Auto reload file changes
  autocmd FocusGained,BufEnter * :checktime

  " Dont regconize quickfix list as buffer
  augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
  augroup END

  augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | call v:lua.big_file_disable() | endif
  augroup END
]]
