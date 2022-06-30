local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main"
  },
  filetype = "cue",
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "go", "gomod", "html", "javascript", "markdown",
    "json", "lua", "python", "fish", "comment", "query", "nix",
    "rust", "toml", "tsx", "typescript", "vue", "yaml", "hcl",
    "java", "scala", "cue", "graphql", "proto",
  },

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
    disable = { "python" },
  },

  playground = {
    enable = true,
  },

  autotag = {
    enable = true
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      ['<CR>'] = 'textsubjects-big',
    }
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
