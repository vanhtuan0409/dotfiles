local M = {}
local spinners = { "", "" }

function M.lsp_message()
  local data = vim.lsp.util.get_progress_messages()[1]
  if not data or data.name == "null-ls" then
    return ""
  end

  local msg = data.message or ""
  local percentage = data.percentage or 0
  local title = data.title or ""
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  local content = string.format("%s %s %s (%s%%%%)", spinners[frame + 1], title, msg, percentage)
  return content
end

function M.attached_lsp()
  local servers = {}
  for _, v in pairs(vim.lsp.buf_get_clients()) do
    table.insert(servers, v.name)
  end
  return table.concat(servers, ", ")
end

return M
