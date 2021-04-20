local goimports = {
  formatCommand = "goimports",
  formatStdin = true,
}

local rustfmt = {
  formatCommand = "rustfmt --edition 2018",
  formatStdin = true,
}

local prettier = {
  formatCommand = ([[
    prettier
      --stdin-filepath ${INPUT}
      ${--config-precedence:configPrecedence}
      ${--tab-width:tabWidth}
      ${--single-quote:singleQuote}
      ${--trailing-comma:trailingComma}
  ]]):gsub("\n", ""),
  formatStdin = true,
}

local languages = {
  go = {goimports},
  rust = {rustfmt},
  typescript = {prettier},
  javascript = {prettier},
  typescriptreact = {prettier},
  javascriptreact = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
  yaml = {prettier},
}

return languages
