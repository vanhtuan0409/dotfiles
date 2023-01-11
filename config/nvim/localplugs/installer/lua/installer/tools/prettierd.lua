return {
	cmd = "./node_modules/.bin/prettierd",

	install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install @fsouza/prettierd@latest
  ]],
}
