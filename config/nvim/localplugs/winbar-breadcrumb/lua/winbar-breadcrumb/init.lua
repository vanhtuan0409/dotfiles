local M = {}
local config = require'winbar-breadcrumb.config'
local utils = require'winbar-breadcrumb.utils'

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
  local global_config = config.get()
  local enabled_sources = global_config.sources

  local chunks = {}
  for _, s in ipairs(enabled_sources) do
    local source_config = s
    if type(source_config) == "function" then
      source_config = { fn = source_config }
    end

    local generator = source_config.fn
    local chunk_size = source_config.chunk_size or global_config.chunk_size
    local ellipsis_text = source_config.ellipsis_text or global_config.ellipsis_text
    local highlighted = source_config.highlighted

    local fragments = ellipsis_slice(generator(), chunk_size, ellipsis_text)
    fragments = vim.tbl_map(function(item)
      if highlighted then
        return item
      end
      return utils.add_hl(item, "BreadcrumbText")
    end, fragments)

    vim.list_extend(chunks, fragments)
  end

  return "  " .. table.concat(chunks, utils.add_hl(global_config.separator, "BreadcrumbSep"))
end

function M.setup(opts)
  opts = opts or {}
  config.set_defaults(opts)

  local winbar_ag = vim.api.nvim_create_augroup("WinbarBreadcrumb", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group= winbar_ag,
    pattern = "*",
    callback = function(params)
      local global_config = config.get()
      if vim.bo.filetype == "" or vim.tbl_contains(global_config.ignore_filetypes, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end
      vim.opt_local.winbar = "%{%v:lua.require'winbar-breadcrumb'.render_breadcrumb()%}"
    end,
  })
end

return M
