local function lsp_message()
  if vim.tbl_count(vim.lsp.buf_get_clients()) < 1 then
    return ''
  end

  local lsp_status = require'utils'.prequire('lsp-status')
  if not lsp_status then
    return ''
  end

  return lsp_status.status_progress()
end

local function gps_status()
  local gps = require'utils'.prequire('nvim-gps')
  if not gps or not gps.is_available() then
    return ''
  end
  return gps.get_location()
end

local function attached_lsp()
  local servers = {}
  for _, v in pairs(vim.lsp.buf_get_clients()) do
    table.insert(servers, v.name)
  end
  return table.concat(servers, ", ")
end

require'lualine'.setup {
  options = {
    theme = 'gruvbox-material',
    icons_enabled = false,
    section_separators = '',
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_a = {
      { 'mode', upper = true },
    },
    lualine_b = {
      'filename'
    },
    lualine_c = {
      gps_status,
    },
    lualine_x = {
      'g:metals_status',
      lsp_message,
      attached_lsp,
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
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
}
