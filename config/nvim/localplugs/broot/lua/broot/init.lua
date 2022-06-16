local M = {}
local gcfg = require("broot.config")
local term = require("broot.term")

local setup_cfg_file = function()
  local override_path = gcfg.get("override_cfg_path")
  if vim.fn.empty(vim.fn.glob(override_path)) == 0 then
    return
  end
  vim.fn.writefile({
    '[[verbs]]',
    'key = "enter"',
    'execution = ":print_path"',
    'apply_to = "file"',
  }, override_path)
end

function M.setup(opts)
  gcfg.set(opts)
  setup_cfg_file()

  -- create cmd
  vim.api.nvim_create_user_command("Broot", function(params)
    local cwd = params.args
    if cwd == nil or cwd == "" then
      cwd = "."
    end
    M.open(cwd)
  end, {
    nargs = "?",
    bang = true,
  })
end

function M.open(cwd)
  cwd = vim.fn.expand(cwd)
  local cfg_paths = table.concat(gcfg.get_broot_cfg_paths(), ";")
  local out_path = gcfg.get("out_path")
  local cmd = table.concat({
    gcfg.get("cmd"),
    "--conf",
    string.format('"%s"',cfg_paths),
    cwd,
    ">",
    out_path,
  }, " ")

  term.open(cmd, function(job_id, code, event)
    if code == 0 then
      vim.cmd ":bd!"
    end
    if vim.fn.filereadable(out_path) then
      local files = vim.fn.readfile(out_path)
      for i, file in pairs(files) do
        if file then
          vim.cmd(string.format("edit %s", file))
        end
      end
      vim.fn.delete(out_path)
    end
  end)
end

return M
