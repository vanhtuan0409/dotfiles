require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "go", "html", "javascript",
    "json", "markdown", "lua", "python", "regex",
    "rust", "toml", "tsx", "typescript", "vue", "yaml" },
  highlight = {
    enable = true,
  },
}
