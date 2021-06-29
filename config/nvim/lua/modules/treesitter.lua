require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dart", "go", "html", "javascript",
    "json", "lua", "python", "fish", "comment",
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
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-big',
    }
  }
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldlevelstart=99]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
