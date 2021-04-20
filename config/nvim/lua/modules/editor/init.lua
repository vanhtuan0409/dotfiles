require('gitsigns').setup {
  sign_priority = 5
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dart", "go", "html", "javascript",
    "json", "markdown", "lua", "python", "regex",
    "rust", "toml", "tsx", "typescript", "vue", "yaml" },

  highlight = {
    enable = true,
  },
}

local lsp_status = require'lsp-status'
lsp_status.config {
  current_function = false,
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = '',
}
lsp_status.register_progress()

require'lspsaga'.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  code_action_icon = ' ',
  finder_definition_icon = '* ',
  finder_reference_icon = '* ',
  finder_action_keys = {
    quit = '<Esc>'
  },
  code_action_keys = {
    quit = '<Esc>'
  },
  rename_action_keys = {
    quit = '<Esc>'
  }
}

