return {
  cmd = "./goimports",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/cmd/goimports
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

