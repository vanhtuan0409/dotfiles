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
    disable = function(lang, bufnr)
      return vim.api.nvim_buf_get_var(bufnr, 'bigfile')
    end
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

  context_commentstring = {
    enable = true,
    config = {
      fish = '# %s',
    }
  }
}
