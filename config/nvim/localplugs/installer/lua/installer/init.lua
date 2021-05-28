local M = {}
local tools = require'installer/tools'

local function install_path(tool)
  return vim.fn.stdpath('data') .. '/installer_bins/' .. tool
end

local function is_installed(tool)
  return vim.fn.isdirectory(install_path(tool)) == 1
end

local function run_command(script, path, onExit)
  vim.cmd("new")
  local shell = vim.o.shell
  vim.o.shell = "/bin/bash"
  local opts = {
    ["cwd"] = path,
    ["on_exit"] = onExit,
  }
  vim.fn.termopen("set -e\n" .. script, opts)
  vim.o.shell = shell
  vim.cmd("startinsert")
end

function M.ensure(tool, force)
  if not tools[tool] then
    error("There is no configuration for this tool " .. tool)
  end
  local config = tools[tool]

  local path = install_path(tool)
  if is_installed(tool) and not force then
    return
  end
  vim.fn.mkdir(path, "p")

  local function onExit(_, code)
    if code ~= 0 then
      error("Could not install " .. tool)
    end
    print("Successully installed " .. tool)
  end

  run_command(config.install_script, path, onExit)
end

function M.uninstall(tool)
  if not tools[tool] then
    error("There is no configuration for this tool " .. tool)
  end
  local config = tools[tool]

  local path = install_path(tool)
  if not is_installed(tool) then
    return
  end

  if vim.fn.confirm("Uninstall " .. tool .. " ?", "&Yes\n&Cancel") ~= 1 then
    return
  end

  local function onExit(_, code)
    if code ~= 0 then
      error("Could not uninstall " .. tool)
    end

    if vim.fn.delete(path, "rf") ~= 0 then -- here 0: success, -1: fail
      error("Could not delete directory " .. lang)
    end

    print("Successfully uninstalled " .. tool)
  end

  run_command(config.uninstall_script or "", path, onExit)
end

function M.available_tools()
  return vim.tbl_keys(tools)
end

function M.installed_tools()
  return vim.tbl_filter(
    function(key) return is_installed(key) end,
    M.available_tools()
  )
end

function M.bin(tool)
  local config = tools[tool]
  return install_path(tool) .. "/" .. config.cmd
end

function M.update_all()
  for _, tool in pairs(M.installed_tools()) do
    M.ensure(tool, true)
  end
end

function M.setup(opts) 
  opts = opts or {
    ensure = {},
  }

  -- ensure required tools
  for key, val in pairs(opts.ensure) do
    M.ensure(val)
  end
end

return M
