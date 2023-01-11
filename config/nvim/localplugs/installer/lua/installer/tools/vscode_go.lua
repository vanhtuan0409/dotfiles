return {
	cmd = "./dist/debugAdapter.js",

	install_script = [[
  ! test -f package.json && git clone git@github.com:golang/vscode-go.git .
  git pull && npm install && npm run compile
  ]],
}
