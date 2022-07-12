local M = {}
local sources = require'winbar-breadcrumb.sources'

local config = {}
local default_config = {
  separator = "  ",
  chunk_size = 3,
  ellipsis_text = "...",
  ignore_filetypes = {},
  sources = {
    sources.workspace_path,
    {
      fn = sources.navic,
      highlighted = true,
    }

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
