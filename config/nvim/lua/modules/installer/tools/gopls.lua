return {
  cmd = "./gopls",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}
