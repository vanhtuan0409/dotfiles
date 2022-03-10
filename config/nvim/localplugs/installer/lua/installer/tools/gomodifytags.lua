return {
  cmd = "./gomodifytags",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install github.com/fatih/gomodifytags@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

