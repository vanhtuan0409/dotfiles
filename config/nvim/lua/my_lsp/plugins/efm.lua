local goimports = {
  formatCommand = "goimports",
  formatStdin = true,
}

local rustfmt = {
  formatCommand = "rustfmt --edition 2018",
  formatStdin = true,
}

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local languages = {
  go = {goimports},
  rust = {rustfmt},
  typescript = {prettier},
  javascript = {prettier},
  typescriptreact = {prettier},
  javascriptreact = {prettier},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
}

return languages
