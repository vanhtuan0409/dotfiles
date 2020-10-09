:lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "bash", "css", "go", "html", "javascript",
      "json", "markdown", "lua", "python", "regex",
      "rust", "toml", "tsx", "typescript", "vue", "yaml" },
    highlight = {
      enable = true,
    },
  }
EOF

autocmd BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile set filetype=toml
