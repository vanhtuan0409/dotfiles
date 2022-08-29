local modules = require("modules.lualine.modules")
local default_bg = vim.opt.background:get()

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
  winbar = {
    lualine_a = {
      {
        require'winbar-breadcrumb'.render_breadcrumb,
        color = { bg = default_bg },
        cond = function()
          local file = vim.fn.expand "%"
          return vim.bo.filetype ~= "" and file ~= "[packer]" and file ~= ""
        end,
      }
    },
    lualine_z = {
      {
        "b:jsonschema",
        color = "LspCodeLens",
      },
    }
  },
}
