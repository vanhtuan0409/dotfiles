set laststatus=2
set showtabline=2

if g:lsp_mode == "lsp"
  autocmd User LspDiagnosticsChanged call lightline#update()
endif

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'tabline': {
  \   'left': [['buffers']],
  \ },
  \ 'active': {
  \   'left': [['mode']],
  \   'right': [['lineinfo'],
  \             ['filetype'],
  \             ['lightline_status']],
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \ },
  \ 'component_function': {
  \   'lightline_status': 'LightlineStatus',
  \ },
  \ }

function! LightlineStatus() abort
  if g:lsp_mode == "lsp"
    return LspStatus()
  else
    return coc#status()
  endif
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

