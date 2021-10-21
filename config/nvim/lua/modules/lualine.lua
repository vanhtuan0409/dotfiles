local spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

local function lsp_message()
  if vim.tbl_count(vim.lsp.buf_get_clients()) < 1 then
    return ''
  end

  local lsp_status = require'utils'.prequire('lsp-status')
  if not lsp_status then
    return ''
  end

  local status_parts = {}
  local buf_diagnostics = lsp_status.diagnostics() or nil

  -- get diagnostics message
  if buf_diagnostics then
    if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.errors)
    end

    if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.warnings)
    end

    if buf_diagnostics.info and buf_diagnostics.info > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.info)
    end

    if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.hints)
    end
  end
  if vim.tbl_count(status_parts) == 0 then
    table.insert(status_parts, '')
  end

  -- get loading status
  local buf_messages = lsp_status.messages()
  for _, msg in ipairs(buf_messages) do
    if msg.progress then
      local contents = {}

      if msg.spinner then
        local idx = (msg.spinner % #spinner_frames) + 1
        table.insert(contents, spinner_frames[idx])
      end

      if msg.percentage then
        local percentage = string.format("(%.0f%%%%)", msg.percentage)
        table.insert(contents, percentage)
      end

      if vim.tbl_count(contents) > 0 then
        local progress = vim.trim(table.concat(contents, ' '))
        table.insert(status_parts, progress)
        break
      end
    end
  end

  -- combine parts
  local status = vim.trim(table.concat(status_parts, ' '))
  return status
end

local function gps()
  local gps = require'utils'.prequire('nvim-gps')
  if not gps or not gps.is_available() then
    return ''
  end
  return gps.get_location()
end

local function attached_lsp()
  local servers = {}
  for k, v in pairs(vim.lsp.buf_get_clients()) do
    table.insert(servers, v.name)
  end
  return table.concat(servers, ", ")
end

local function indent_type()
  local is_big_file = vim.F.npcall(vim.api.nvim_buf_get_var, 0, 'bigfile')
  if is_big_file then
    return ""
  end

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
      gps,
    },
    lualine_x = { 
      attached_lsp,
      lsp_message,
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
