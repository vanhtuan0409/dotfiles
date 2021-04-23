local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.vim"

-- install packer if not existed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
vim.cmd "autocmd BufWritePost main.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

local packer = require'packer'
packer.startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- Themes
    use { "sainnhe/gruvbox-material", config = require'modules/themes'.gruvbox }

    -- Enhancement
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'haya14busa/incsearch.vim'
    use { 'windwp/nvim-autopairs', config = [[require'modules/autopairs']], after = 'nvim-compe' }
    use 'junegunn/fzf.vim'
    use 'wakatime/vim-wakatime'
    use 'lewis6991/gitsigns.nvim'

    -- Syntax highlight
    use 'chr4/nginx.vim'
    use { 'hashivim/vim-terraform', config = [[require'modules/terraform']] }
    use 'robbles/logstash.vim'

    -- Lua utils
    use 'nvim-lua/plenary.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'windwp/nvim-ts-autotag'

    -- Status
    use 'hoob3rt/lualine.nvim'
    use { 'romgrk/barbar.nvim', config = [[require'modules/barbar']] }

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use { 'hrsh7th/nvim-compe', config = [[require'modules/compe']] }
    use 'glepnir/lspsaga.nvim'
  end,
  config = {
    compile_path = compile_path,
  },
})

require 'modules/lsp'
require 'modules/editor'
require 'modules/debugging'
require 'modules/statusline'
require("modules/installer").setup{
  ensure = { 
   "gopls", "rust_analyzer", "efm", "tsserver",
   "prettier", "goimports",
   "vscode_go",
  }
}
