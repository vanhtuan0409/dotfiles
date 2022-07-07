local M = {}
local sources = require'winbar-breadcrumb.sources'

local config = {}
local default_config = {
  separator = "  ",
  source_chunk_size = 3,
  ellipsis_text = "...",
  sources = {
    sources.workspace_path,
    sources.navic,
  }
}

function M.set_defaults(opts)
  local merged = vim.tbl_extend("force", default_config, opts)
  config = merged
end

function M.get()
  return config
end

return M
