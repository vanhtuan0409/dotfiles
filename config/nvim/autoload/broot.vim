" Normalize configs
let s:choice_file_path = get(g:, 'broot_choice_file', '/tmp/chosenfile')
let s:broot_command = get(g:, 'broot_command_override', 'broot')
let s:broot_default_conf_path = get(g:, 'broot_default_conf_path', expand('~/.config/broot/conf.hjson'))

" Materialize config override
let s:broot_vim_conf_path = expand('~/.config/broot/vim_override.toml')
let s:broot_conf_paths = '"' . s:broot_vim_conf_path. ';' .s:broot_default_conf_path . '"'
let s:broot_vim_conf = get(g:, 'broot_vim_conf', [
            \ '[[verbs]]',
            \ 'key = "enter"',
            \ 'execution = ":print_path"',
            \ 'apply_to = "file"',
            \ ])
call writefile(s:broot_vim_conf, s:broot_vim_conf_path)

if has('nvim')
  function! broot#OpenBrootIn(path, edit_cmd)
    let l:currentPath = expand(a:path)
    let l:brootCallback = { 'name': 'broot', 'edit_cmd': a:edit_cmd }
    function! brootCallback.on_exit(job_id, code, event)
      if a:code == 0
        silent! :bd!
      endif
      try
        if filereadable(s:choice_file_path)
          for f in readfile(s:choice_file_path)
            exec self.edit_cmd . f
          endfor
          call delete(s:choice_file_path)
        endif
      endtry
    endfunction
    enew
    let l:exec_cmd = s:broot_command . ' --conf ' . s:broot_conf_paths . ' --out ' . s:choice_file_path . ' "' . l:currentPath . '"'
    call termopen(l:exec_cmd, l:brootCallback)
    startinsert
  endfunction
else
  function! broot#OpenBrootIn(path, edit_cmd)
    let l:currentPath = expand(a:path)
    let l:exec_cmd = '!' . s:broot_command . ' --conf ' . s:broot_conf_paths . ' --out ' . s:choice_file_path . ' "' . l:currentPath . '"'
    silent exec l:exec_cmd
    if filereadable(s:choice_file_path)
      for f in readfile(s:choice_file_path)
        exec a:edit_cmd . f
      endfor
      call delete(s:choice_file_path)
    endif
    redraw!
    " reset the filetype to fix the issue that happens
    " when opening broot on VimEnter (with `vim .`)
    filetype detect
  endfun
endif
