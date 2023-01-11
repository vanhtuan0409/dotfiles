return {
	cmd = "./node_modules/.bin/yaml-language-server",

	install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install yaml-language-server@latest
  ]],
}
