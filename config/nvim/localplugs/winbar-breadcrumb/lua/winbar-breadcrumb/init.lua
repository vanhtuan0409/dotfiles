local M = {}
local config = require'winbar-breadcrumb.config'

local function ellipsis_slice(arr, max_len, ellipsis_text)
  if #arr <= max_len then
    return arr
  end

  local ret = {arr[1], ellipsis_text}
  local idx_start = #arr-(max_len-2)
  local idx_end = #arr
  for i = idx_start,idx_end,1 do
    table.insert(ret, arr[i])
  end
  return ret
end

function M.render_breadcrumb()
  local cur_config = config.get()
  local enabled_sources = cur_config.sources

  local chunks = {}
  for _, s in ipairs(enabled_sources) do
    local fragments = ellipsis_slice(s(), cur_config.source_chunk_size, cur_config.ellipsis_text)
    vim.list_extend(chunks, fragments)
  end

  return "  " .. table.concat(chunks, cur_config.separator)
end

function M.setup(opts)
  opts = opts or {}
  config.set_defaults(opts)
  vim.o.winbar = "%{%v:lua.require'winbar-breadcrumb'.render_breadcrumb()%}"
end

return M
