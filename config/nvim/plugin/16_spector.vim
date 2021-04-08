let g:vimspector_install_gadgets = ['vscode-go']
let g:vimspector_enable_mappings = 'HUMAN'

nmap <Leader>di <Plug>VimspectorBalloonEval
nmap <F1> <cmd>VimspectorReset<CR>
nmap <F2> <cmd>call vimspector#ClearBreakpoints()<CR>
