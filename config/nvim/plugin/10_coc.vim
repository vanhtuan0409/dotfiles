" Extension for coc.nvim
let g:coc_global_extensions = [
  \'coc-json',
  \'coc-tsserver',
  \'coc-prettier',
  \'coc-pyright',
  \'coc-rust-analyzer',
  \'coc-eslint',
  \'coc-go',
  \'coc-lua',
  \]


if g:lsp_mode == "coc"
  command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  command! -nargs=0 Format :call CocAction('format')
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
  command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap keys for coc
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> K :call <SID>coc_show_documentation()<CR>
  nmap <leader>rn <Plug>(coc-rename)
  nmap <leader>ga <Plug>(coc-codeaction-line)

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>coc_check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
else
  let g:coc_start_at_startup = 0
endif

function! s:coc_check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:coc_show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
