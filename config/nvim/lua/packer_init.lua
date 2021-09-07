local execute = vim.api.nvim_command
local fn = vim.fn

-- install packer if not existed
if fn.empty(fn.glob(PACKER_INSTALL_PATH)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', PACKER_INSTALL_PATH})
end

execute 'packadd packer.nvim'
vim.cmd [[
  augroup packer_auto_compile
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]]
vim.cmd [[command! Psync PackerSync]]
vim.cmd [[command! Pcompile PackerCompile]]
vim.cmd [[command! Pcprofile PackerCompile profile=true]]

local packer = require'packer'
packer.init {
  compile_path = PACKER_COMPILED_PATH,
  profile = {
    threshold = 1,
  }
}

return packer
