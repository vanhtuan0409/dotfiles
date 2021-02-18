set laststatus=2
set showtabline=2

autocmd User LspDiagnosticsChanged call lightline#update()
function! LspStatus() abort
  return luaeval("require('lsp-status').status()")
endfunction

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
  \             ['lspstatus']],
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \ },
  \ 'component_function': {
  \   'lspstatus': 'LspStatus',
  \ },
  \ 'component_visible_condition': {
  \   'lspstatus': 'not vim.tbl_isempty(vim.lsp.buf_get_clients(0))'
  \ },
  \ }
