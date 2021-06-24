return {
  cmd = "",

  uninstall_script = [[
  pipx uninstall black
  ]],

  install_script = [[
  pipx install --force black
  ]]
}
