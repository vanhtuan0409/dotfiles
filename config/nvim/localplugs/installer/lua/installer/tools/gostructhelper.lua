return {
	cmd = "./gostructhelper",

	install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install github.com/vanhtuan0409/gostructhelper/cmds/gostructhelper@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]],
}
