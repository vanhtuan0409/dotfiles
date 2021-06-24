require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dart", "go", "html", "javascript",
    "json", "lua", "python", "fish",
    "rust", "toml", "tsx", "typescript", "vue", "yaml" },

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
    disable = { "python" },
  },

  autotag = {
    enable = true
  }
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldlevelstart=99]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
