local M = {}

local defaults = {
  cmd = "broot",
  default_cfg_path  = "~/.config/broot/conf.hjson",
  override_cfg_path = "~/.config/broot/nvim_override.toml",
  out_path = "/tmp/chosenfile"
}

local configs = vim.deepcopy(defaults)

function M.get(field)
  if field then
    return configs[field]
  end
  return configs
end

function M.set(user_cfg)
  configs = vim.tbl_extend("force", configs, user_cfg)
  vim.validate({
    cmd               = {configs.cmd, "s"},
    default_cfg_path  = {configs.default_cfg_path, "s"},
    override_cfg_path = {configs.override_cfg_path, "s"},
    out_path          = {configs.out_path, "s"}
  })
  configs.default_cfg_path = vim.fn.expand(configs.default_cfg_path)
  configs.override_cfg_path = vim.fn.expand(configs.override_cfg_path)
  configs.out_path = vim.fn.expand(configs.out_path)
end

function M.get_broot_cfg_paths()
  return {
    configs.default_cfg_path,
    configs.override_cfg_path,
  }
end

return M
