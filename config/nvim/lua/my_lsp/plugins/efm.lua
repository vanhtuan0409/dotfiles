local goimports = {
  formatCommand = "goimports",
  formatStdin = true,
}

local rustfmt = {
  formatCommand = "rustfmt",
  formatStdin = true,
}

local languages = {
  go = {goimports},
  rust = {rustfmt},
}

return languages
