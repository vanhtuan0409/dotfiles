return {
  cmd = "./dlv",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install github.com/go-delve/delve/cmd/dlv@master
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}
