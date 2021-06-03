return {
  cmd = "./rust-analyzer",

  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  mchn=$(uname -m | tr "[:upper:]" "[:lower:]")

  if [ $mchn = "arm64" ]; then
    mchn="aarch64"
  fi

  case $os in
  linux)
  platform="unknown-linux-gnu"
  ;;
  darwin)
  platform="apple-darwin"
  ;;
  esac

  curl -L -o "rust-analyzer-$mchn-$platform.gz" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$mchn-$platform.gz"
  gzip -d rust-analyzer-$mchn-$platform.gz

  mv rust-analyzer-$mchn-$platform rust-analyzer

  chmod +x rust-analyzer
  ]]
}
