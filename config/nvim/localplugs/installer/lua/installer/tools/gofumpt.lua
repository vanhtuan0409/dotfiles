return {
  cmd = "./gofumpt",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v mvdan.cc/gofumpt
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

