local M = {}

function M.prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  return nil
end

function M.packer_lazy_load(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

return M
