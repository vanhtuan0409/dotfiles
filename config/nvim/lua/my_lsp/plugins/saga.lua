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

-- Ref: https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/hover.lua#L28
-- Avoid overlapping popup
function _G.custom_show_line_diagnostics(...)
  if not require'lspsaga.hover'.has_saga_hover() then
    require'lspsaga.diagnostic'.show_line_diagnostics(...)
  end
end

