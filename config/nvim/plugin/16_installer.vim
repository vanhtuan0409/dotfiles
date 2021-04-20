function s:installer_ensure(tool)
  call v:lua.require("modules/installer").ensure(a:tool, v:true)
endfunction

function s:installer_uninstall(tool)
  call v:lua.require("modules/installer").uninstall(a:tool)
endfunction

function s:installer_available_tools() abort
  return luaeval('require("modules/installer").available_tools()')
endfunction

function s:installer_installed_tools() abort
  return luaeval('require("modules/installer").installed_tools()')
endfunction

function s:installer_update_all() abort
  return luaeval('require("modules/installer").update_all()')
endfunction

" Interface
command! -nargs=1 -complete=custom,s:complete_install InstallerEnsure :call s:installer_ensure('<args>')
command! -nargs=1 -complete=custom,s:complete_uninstall InstallerUninstall :call s:installer_uninstall('<args>')
command! InstallerUpdateAll :call s:installer_update_all()

function! s:complete_install(arg, line, pos) abort
  return join(s:installer_available_tools(), "\n")
endfunction
function! s:complete_uninstall(arg, line, pos) abort
  return join(s:installer_installed_tools(), "\n")
endfunction
