return {
	cmd = "./lua-language-server",

	install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  arch=$(uname -m | awk -F'_' '{print $2}' | tr "[:upper:]" "[:lower:]")

  download_link=$(curl -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_download_url' | grep "$os-x$arch" | cut -d\" -f4)
  curl -L -o sumneko-lua.vsix $download_link
  rm -rf sumneko-lua
  unzip sumneko-lua.vsix -d sumneko-lua
  rm sumneko-lua.vsix

  chmod +x sumneko-lua/extension/server/bin/lua-language-server
  echo "#!/usr/bin/env bash" > lua-language-server
  echo "\$(dirname \$0)/sumneko-lua/extension/server/bin/lua-language-server -E -e LANG=en \$(dirname \$0)/sumneko-lua/extension/server/main.lua \$*" >> lua-language-server
  chmod +x lua-language-server
  ]],
}
