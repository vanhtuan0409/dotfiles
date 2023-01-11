return {
	cmd = "./node_modules/.bin/typescript-language-server",

	install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install typescript-language-server@latest typescript@latest
  ]],
}
