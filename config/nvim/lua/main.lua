local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.vim"
local localplugspath = fn.stdpath("config") .. "/localplugs"
local localplug = function(plug)
  return localplugspath .. "/" .. plug
end

-- install packer if not existed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require'packer'
packer.startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Installer
    use { localplug("installer"),
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'installer'.setup{
        ensure = {
          "gopls", "rust_analyzer", "efm", "tsserver", "pyright",
          "prettier", "goimports",
          "vscode_go",
        }
      }]]
    }

    -- Themes
    use { 'sainnhe/gruvbox-material',
      config = [[require'modules/themes'.gruvbox()]]
    }

    -- Enhancement
    use { localplug("broot"),
      setup = [[require'modules/broot']],
      cmd = {'Broot', 'BrootCurrentDirectory', 'BrootWorkingDirectory'},
    }
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'haya14busa/incsearch.vim'
    use { 'windwp/nvim-autopairs', config = [[require'modules/autopairs']], event = 'BufEnter' }
    use 'wakatime/vim-wakatime'
    use { 'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'modules/gitsigns']],
      event = 'BufEnter'
    }
    use { 'folke/trouble.nvim',
      setup = [[require'modules/trouble'.setup()]],
      config = [[require'modules/trouble'.config()]],
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    }
    -- use { 'junegunn/fzf.vim',
    --   setup = [[require'modules/fzf']],
    --   cmd = { 'Files', 'Buffers', 'Rg' }
    -- }
    use { 'camspiers/snap',
      config = [[require'modules/snap']],
      keys = {'<C-p>', '<C-f>', '<C-b>'},
    }
    -- use { 'nvim-telescope/telescope.nvim',
    --   requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    --   setup = [[require'modules/telescope'.setup()]],
    --   config = [[require'modules/telescope'.config()]],
    --   cmd = { 'Telescope' }
    -- }
    use { 'lukas-reineke/indent-blankline.nvim', branch = "lua",
      setup = [[require'modules/indent_blankline']],
    }
    use 'kevinhwang91/nvim-bqf'

    -- Syntax highlight
    use 'chr4/nginx.vim'
    use { 'hashivim/vim-terraform', config = [[require'modules/terraform']] }
    use 'robbles/logstash.vim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
      config = [[require'modules/treesitter']],
      requires = {'windwp/nvim-ts-autotag'},
    }

    -- Status
    use { 'hoob3rt/lualine.nvim', config = [[require'modules/lualine']] }
    use { "jose-elias-alvarez/buftabline.nvim",
      setup = [[require'modules/buftabline'.setup()]],
      config = [[require'modules/buftabline'.config()]],
    }
    -- use { 'romgrk/barbar.nvim',
    --   disable = true,
    --   setup = [[require'modules/barbar'.setup()]],
    --   config = [[require'modules/barbar'.config()]],
    --   after = 'gruvbox-material',
    -- }

    -- Debugging
    use { 'rcarriga/nvim-dap-ui',
      requires = {
        {localplug('installer')},
        {'mfussenegger/nvim-dap',
          config = [[require'modules/debugging/dap']],
          keys = {
            "<F1>", "<F5>", "<F9>", "<F10>", "<F11>", "<F12>", 
          }
        },
      },
      config = [[require'modules/debugging/dapui']],
      after = {'nvim-dap'},
    }

    -- Snippets
    use { 'hrsh7th/vim-vsnip', requires = {'hrsh7th/vim-vsnip-integ'} }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      requires = { localplug('installer')},
      config = [[require'modules/lsp']],
    }
    use { 'nvim-lua/lsp-status.nvim', config = [[require'modules/lspstatus']] }
    use { 'hrsh7th/nvim-compe', config = [[require'modules/compe']], event = 'InsertEnter' }
    use { 'glepnir/lspsaga.nvim', config = [[require'modules/lspsaga']], cmd = 'Lspsaga' }
    use 'ray-x/lsp_signature.nvim'
  end,
  config = {
    compile_path = compile_path,
    profile = {
      threshold = 1,
    }
  },
})

