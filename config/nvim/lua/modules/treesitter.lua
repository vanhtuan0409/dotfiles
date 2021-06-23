require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dart", "go", "html", "javascript",
    "json", "lua", "python", "fish",
    "rust", "toml", "tsx", "typescript", "vue", "yaml" },

  highlight = {
    enable = true,
  },

  indent = {
    enable = { "javascriptreact", "typescriptreact" }
  },

  autotag = {
    enable = true
  }
}
