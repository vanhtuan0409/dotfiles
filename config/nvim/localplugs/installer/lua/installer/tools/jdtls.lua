return {
	cmd = "./bin/jdtls",
	dir = "./jdtls",

	install_script = [[
  rm -rf jdt-language-server-latest.tar.gz
  mkdir -p jdtl
  rm -rf jdtls/*
  wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
  tar xzf jdt-language-server-latest.tar.gz -C jdtls
  ]],
}
