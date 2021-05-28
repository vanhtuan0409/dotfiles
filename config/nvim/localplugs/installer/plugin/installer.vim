function! s:installer_complete(args, line, pos)
  let items = luaeval('require("installer.command").complete(_A[1], _A[2], _A[3])', [a:args, a:line, a:pos])
  return join(items, "\n")
endfunction

command! -nargs=+ -complete=custom,s:installer_complete Installer lua require('installer.command').load_command(<f-args>)
