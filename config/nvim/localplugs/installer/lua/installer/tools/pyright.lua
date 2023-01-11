return {
	cmd = "./node_modules/.bin/pyright-langserver",

	install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install pyright@latest
  ]],
}
