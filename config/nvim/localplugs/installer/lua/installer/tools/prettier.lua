return {
	cmd = "./node_modules/.bin/prettier",

	install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install prettier@latest
  ]],
}
