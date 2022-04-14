require("globals")
require("options")
require("plugins")
require("keybindings")

function big_file_disable()
  local fpath = vim.fn.expand("%")
  local fsize = vim.fn.getfsize(fpath)
  local threshold = 512 * 1024 -- 512Kb
  if fsize > threshold then
    vim.cmd [[
      set filetype=ignored
      set eventignore+=BufReadPost

      setlocal syntax=off
      setlocal foldmethod=manual
      setlocal noloadplugins
    ]]
    vim.api.nvim_buf_set_var(0, 'bigfile', true)
  else
    vim.cmd [[
      set eventignore-=BufReadPost
    ]]
  end
end

vim.cmd [[
  " Dont regconize quickfix list as buffer
  augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
  augroup END

  augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * call v:lua.big_file_disable()
  augroup END
]]
