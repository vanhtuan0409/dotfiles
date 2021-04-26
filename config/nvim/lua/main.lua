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

require("modules/installer").setup{
  ensure = { 
   "gopls", "rust_analyzer", "efm", "tsserver",
   "prettier", "goimports",
   "vscode_go",
  }
}

local packer = require'packer'
packer.startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- Themes
    use { 'sainnhe/gruvbox-material',
      config = [[require'modules/themes'.gruvbox()]]
    }

    -- Enhancement
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'haya14busa/incsearch.vim'
    use { 'windwp/nvim-autopairs', config = [[require'modules/autopairs']] }
    use { 'junegunn/fzf.vim', config = [[require'modules/fzf']] }
    use 'wakatime/vim-wakatime'
    use { 'lewis6991/gitsigns.nvim', config = [[require'modules/gitsigns']] }

    -- Syntax highlight
    use 'chr4/nginx.vim'
    use { 'hashivim/vim-terraform', config = [[require'modules/terraform']] }
    use 'robbles/logstash.vim'

    -- Lua utils
    use 'nvim-lua/plenary.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
      config = [[require'modules/treesitter']],
      requires = {'windwp/nvim-ts-autotag'}
    }

    -- Status
    use { 'hoob3rt/lualine.nvim', config = [[require'modules/lualine']] }
    use { 'romgrk/barbar.nvim',
      setup = [[require'modules/barbar'.setup()]],
      config = [[require'modules/barbar'.config()]],
      after = 'gruvbox-material',
    }

    -- Debugging
    use { 'rcarriga/nvim-dap-ui',
      requires = {
        {'mfussenegger/nvim-dap', config = [[require'modules/debugging/dap']]},
      },
      config = [[require'modules/debugging/dapui']],
    }

    -- Snippets
    use { 'hrsh7th/vim-vsnip', requires = {'hrsh7th/vim-vsnip-integ'} }

    -- LSP
    use { 'neovim/nvim-lspconfig', config = [[require'modules/lsp']] }
    use { 'nvim-lua/lsp-status.nvim', config = [[require'modules/lspstatus']] }
    use { 'hrsh7th/nvim-compe', config = [[require'modules/compe']] }
    use { 'glepnir/lspsaga.nvim', config = [[require'modules/lspsaga']] }
  end,
  config = {
    compile_path = compile_path,
  },
})

