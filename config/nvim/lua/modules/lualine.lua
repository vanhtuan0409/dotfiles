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
  local has_diagnostics = false

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
        local progress = table.concat(contents, ' ')
        table.insert(status_parts, progress)
        break
      end
    end
  end

  -- get diagnostics message
  if buf_diagnostics then
    if buf_diagnostics.errors and buf_diagnostics.errors > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.errors)
      has_diagnostics = true
    end

    if buf_diagnostics.warnings and buf_diagnostics.warnings > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.warnings)
      has_diagnostics = true
    end

    if buf_diagnostics.info and buf_diagnostics.info > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.info)
      has_diagnostics = true
    end

    if buf_diagnostics.hints and buf_diagnostics.hints > 0 then
      table.insert(status_parts, ' ' .. buf_diagnostics.hints)
      has_diagnostics = true
    end
  end
  if not has_diagnostics then
    table.insert(status_parts, ' ')
  end

  -- combine parts
  local status = table.concat(status_parts, ' ')
  return status
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
      attached_lsp,
      lsp_message,
      'g:metals_status',
    },
    lualine_y = {
      { 'filetype' },
    },
    lualine_z = {
      { 'location' },
    },
  },
}
