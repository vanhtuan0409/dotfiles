return {
	cmd = "",

	uninstall_script = [[
  pip uninstall black
  ]],

	install_script = [[
  pip install -U black
  ]],
}
