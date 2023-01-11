return {
	cmd = "./goimports",

	install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install golang.org/x/tools/cmd/goimports@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]],
}
