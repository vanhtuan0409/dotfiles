local M = {}

function M.navic()
  local gps = require'utils'.prequire('nvim-navic')
  if not gps or not gps.is_available() then
    return {}
  end
  local items = gps.get_data()
  if not items then
    return {}
  end

  local ret = {}
  for _, item in ipairs(items) do
    table.insert(ret, string.format("%s%s", item.icon, item.name))
  end
  return ret
end

function M.workspace_path()
  local relative_path = vim.fn.expand("%:.")
  return vim.split(relative_path, "/")
end

return M
