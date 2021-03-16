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
