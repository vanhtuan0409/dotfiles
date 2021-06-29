local snap = require'snap'
local M = {}

local confs = {
  {'<C-p>', snap.config.file { producer = "ripgrep.file" }},
  {'<C-f>', snap.config.vimgrep {}},
  {'<C-b>', snap.config.file { producer = "vim.buffer" }},
}

function M.config()
  vim.cmd [[highlight! link SnapPosition Type]]
  snap.maps(confs)
end

function M.keys()
  local keys = {}
  for idx,item in pairs(confs) do
    keys[idx] = item[1]
  end
  return keys
end

return M
