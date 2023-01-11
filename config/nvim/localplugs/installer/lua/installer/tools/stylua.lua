return {
  cmd = "./stylua",

  install_script = [[
  DOWNLOAD_URL=$(curl -s https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest | jq -r ".assets[] | select(.name == \"stylua-linux.zip\") | .browser_download_url")
  wget -O stylua.zip $DOWNLOAD_URL
  unzip -o stylua.zip
  rm -rf stylua.zip
  ]]
}
