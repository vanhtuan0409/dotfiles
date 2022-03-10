return {
  cmd = "./gopls",

  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install golang.org/x/tools/gopls@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
}
