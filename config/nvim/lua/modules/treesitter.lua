local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main"
  },
  filetype = "norg",
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dart", "go", "gomod", "html", "javascript",
    "json", "lua", "python", "fish", "comment", "query", "nix",
    "rust", "toml", "tsx", "typescript", "vue", "yaml", "hcl",
    "java", "scala",
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

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
