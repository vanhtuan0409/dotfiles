return {
  cmd = "./impl",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/josharian/impl
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

