return {
	cmd = "./gofumpt",

	install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install mvdan.cc/gofumpt@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]],
}
