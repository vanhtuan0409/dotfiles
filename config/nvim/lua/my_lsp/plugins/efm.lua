local goimports = {
  formatCommand = "goimports",
  formatStdin = true,
}

local rustfmt = {
  formatCommand = "rustfmt --edition 2018",
  formatStdin = true,
}

local languages = {
  go = {goimports},
  rust = {rustfmt},
}

return languages
