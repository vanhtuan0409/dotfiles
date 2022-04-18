local execute = vim.api.nvim_command
local fn = vim.fn

-- install packer if not existed
if fn.empty(fn.glob(PACKER_INSTALL_PATH)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', PACKER_INSTALL_PATH})
end

execute 'packadd packer.nvim'
local packer = require'packer'

local compile_ag = vim.api.nvim_create_augroup("packer_auto_compile", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = compile_ag,
  pattern = "plugins.lua",
  desc = "Auto recompile Packer plugins",
  command = "source <afile> | PackerCompile",
})
vim.api.nvim_create_user_command("Psync", "PackerSync", { bang = true })
vim.api.nvim_create_user_command("Pcompile", "PackerCompile", { bang = true })
vim.api.nvim_create_user_command("Pcprofile", "PackerCompile profile=true", { bang = true })

packer.init {
  compile_path = PACKER_COMPILED_PATH,
  profile = {
    threshold = 1,
  }
}

return packer
