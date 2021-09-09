augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua require'modules/lsp/ext'.goimports(200)
augroup END
