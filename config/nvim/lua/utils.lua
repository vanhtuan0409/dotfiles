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

function M.disable_builtins(plugs)
  for _, plug in pairs(plugs) do
    vim.g["loaded_" .. plug] = 1
  end
end

function M.getenv(name, default)
  local ret = vim.fn.getenv(name)
  if ret == vim.NIL then
    return default
  end
  return ret
end

function M.keymap_set_multi(mode, mappings, opts)
  vim.validate({
    mappings = { mappings, 't' }
  })
  for lhs, rhs in pairs(mappings) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
