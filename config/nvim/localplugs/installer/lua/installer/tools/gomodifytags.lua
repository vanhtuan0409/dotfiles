return {
  cmd = "./gomodifytags",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/fatih/gomodifytags
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

