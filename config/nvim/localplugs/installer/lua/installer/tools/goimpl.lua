return {
  cmd = "./impl",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install github.com/josharian/impl@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}

