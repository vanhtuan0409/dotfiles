return {
  cmd = "./dlv",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/go-delve/delve/cmd/dlv@master
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}
