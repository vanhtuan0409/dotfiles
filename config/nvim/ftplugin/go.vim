if g:lsp_mode == "coc"
  nmap gtj :CocCommand go.tags.add json<cr>
  nmap gty :CocCommand go.tags.add yaml<cr>
  nmap gtx :CocCommand go.tags.clear<cr>

  augroup go_au
    autocmd!
    autocmd BufWritePre <buffer> :OR
  augroup END
endif

