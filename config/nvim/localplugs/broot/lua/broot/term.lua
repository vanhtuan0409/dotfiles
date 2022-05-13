local M = {}

function M.open(cmd, on_exit)
  vim.validate({
    cmd = {cmd, "s"},
    on_exit = {on_exit, "f"}
  })

  vim.cmd "enew"
  vim.fn.termopen(cmd, {
    on_exit = on_exit,
  })
  vim.cmd "startinsert"
end

return M
