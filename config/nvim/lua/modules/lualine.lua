local function lsp_message()
  if #vim.lsp.buf_get_clients() > 1 then
    local lsp_status = require'lsp-status'
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

local function indent_type()
  local space = vim.fn.search([[\v^ +]], 'nw') > 0
  local tab = vim.fn.search([[\v^\t+]], 'nw') > 0
  if space and tab then
    return "Mixed"
  elseif tab then
    return "Tab"
  else 
    return "Space"
  end
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
    lualine_c = {
      lsp_message,
    },
    lualine_x = { 
      attached_lsp,
    },
    lualine_y = {
      indent_type,
      { 'filetype' },
    },
    lualine_z = {
      { 'location' },
    },
  },
}
