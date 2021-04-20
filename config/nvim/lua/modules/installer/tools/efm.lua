return {
  cmd = "./efm-langserver",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}
