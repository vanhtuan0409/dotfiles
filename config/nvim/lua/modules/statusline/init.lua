local lsp_status = require'lsp-status'

local function lsp_message()
  if #vim.lsp.buf_get_clients() > 1 then
    return lsp_status.status()
  end
  return ''
end

local function attached_lsp()
  local servers = {}
  for k, v in pairs(vim.lsp.buf_get_clients()) do
    table.insert(servers, v.name)
  end
  return table.concat(servers, ", ")
end

require'lualine'.setup {
  options = {
    theme = 'gruvbox_material',
    icons_enabled = false,
    section_separators = { '', '' },
    component_separators = { '|', '|' },
  },
  sections = {
    lualine_a = {
      { 'mode', upper = true },
    },
    lualine_b = {
      'filename'
    },
    lualine_c = {},
    lualine_x = { 
      lsp_message, attached_lsp,
    },
    lualine_y = {
      { 'filetype' },
    },
    lualine_z = {
      { 'location' },
    },
  },
}
