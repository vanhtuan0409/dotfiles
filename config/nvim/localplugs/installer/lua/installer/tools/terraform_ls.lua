return {
	cmd = "./terraform-ls",

	install_script = [[
  VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform-ls/releases/latest | jq -r ".name" | sed -e "s/^v//")
  DOWNLOAD_URL=https://github.com/hashicorp/terraform-ls/releases/download/v${VERSION}/terraform-ls_${VERSION}_linux_amd64.zip
  wget ${DOWNLOAD_URL} -O terraform-ls.zip
  unzip -o terraform-ls.zip
  rm -rf terraform-ls.zip
  ]],
}
