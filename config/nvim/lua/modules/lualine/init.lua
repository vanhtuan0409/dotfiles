local modules = require("modules.lualine.modules")

require'lualine'.setup {
  options = {
    theme = 'auto',
    icons_enabled = false,
    section_separators = '',
    component_separators = { left = '|', right = '|' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'mode', upper = true },
    },
    lualine_b = {
      'filename'
    },
    lualine_c = {
    },
    lualine_x = {
      'g:metals_status',
      modules.lsp_message,
      modules.attached_lsp,
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },
        colored = false,
      },
    },
    lualine_y = {
      { 'filetype' },
    },
    lualine_z = {
      { 'location' },
    },
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_z = {'tabs'},
  },
}
