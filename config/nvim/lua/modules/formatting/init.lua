local installer = require'modules/installer'

local goimports = {
  formatCommand = installer.bin("goimports"),
  formatStdin = true,
}

local rustfmt = {
  formatCommand = "rustfmt --edition 2018",
  formatStdin = true,
}

local denofmt = {
  formatCommand = "deno fmt --ext ${FILEEXT} -",
  formatStdin = true,
}

local prettier = {
  formatCommand = ([[
    __BIN__
      --stdin-filepath ${INPUT}
      ${--config-precedence:configPrecedence}
      ${--tab-width:tabWidth}
      ${--single-quote:singleQuote}
      ${--trailing-comma:trailingComma}
  ]]):gsub("__BIN__", installer.bin("prettier")):gsub("\n", ""),
  formatStdin = true,
}

local languages = {
  go = {goimports},
  rust = {rustfmt},
  typescript = {denofmt},
  javascript = {denofmt},
  typescriptreact = {denofmt},
  javascriptreact = {denofmt},
  json = {denofmt},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
  yaml = {prettier},
}

return languages
