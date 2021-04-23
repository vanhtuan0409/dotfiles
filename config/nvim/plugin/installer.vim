function s:installer_ensure(tool)
  call v:lua.require("modules/installer").ensure(a:tool, v:true)
endfunction

function s:installer_uninstall(tool)
  call v:lua.require("modules/installer").uninstall(a:tool)
endfunction

" Interface
command! -nargs=1 -complete=custom,v:lua.installer_complete_install InstallerEnsure :call s:installer_ensure('<args>')
command! -nargs=1 -complete=custom,v:lua.installer_complete_uninstall InstallerUninstall :call s:installer_uninstall('<args>')
command! InstallerUpdateAll :call v:lua.require("modules/installer").update_all()

