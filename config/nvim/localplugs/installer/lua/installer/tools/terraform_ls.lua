return {
  cmd = "./terraform-ls",

  install_script = [[
  VERSION=$(GITHUB_TOKEN="$SAFE_GITHUB_TOKEN" gh release list --exclude-drafts -R hashicorp/terraform-ls | grep -i "latest" | awk '{print $1}' | sed -e "s/^v//")
  DOWNLOAD_URL=https://github.com/hashicorp/terraform-ls/releases/download/v${VERSION}/terraform-ls_${VERSION}_linux_amd64.zip
  wget ${DOWNLOAD_URL} -O terraform-ls.zip
  unzip -o terraform-ls.zip
  rm -rf terraform-ls.zip
  ]]
}
