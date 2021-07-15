local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.vim"
local localplugspath = fn.stdpath("config") .. "/localplugs"
local localplug = function(plug)
  return localplugspath .. "/" .. plug
end

-- install packer if not existed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

execute 'packadd packer.nvim'
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
vim.cmd [[command! Psync PackerSync]]
vim.cmd [[command! Pcompile silent PackerCompile]]
vim.cmd [[command! Pcprofile silent PackerCompile profile=true]]

local packer = require'packer'
packer.startup({
  function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    -- Lib
    use { 'svermeulen/vimpeccable' }

    -- Installer
    use { localplug("installer"),
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'installer'.setup{
        ensure = {
          "gopls", "rust_analyzer", "efm", "tsserver", "pyright",
          "prettier", "goimports", "black",
          "dlv", "vscode_go",
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
    use { 'tpope/vim-commentary', event = 'BufRead' }
    use { 'tpope/vim-surround', event = 'BufRead' }
    use { 'tpope/vim-repeat', event = 'BufRead' }
    use { 'haya14busa/incsearch.vim', event = 'BufRead' }
    use { 'windwp/nvim-autopairs',
      config = [[require'modules/autopairs']],
      event = 'BufRead'
    }
    use { 'wakatime/vim-wakatime', opt = true }
    use { 'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'modules/gitsigns']],
      event = 'BufRead'
    }
    use { 'folke/trouble.nvim',
      setup = [[require'modules/trouble'.setup()]],
      config = [[require'modules/trouble'.config()]],
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    }
    use { 'junegunn/fzf.vim',
      disable = true,
      setup = [[require'modules/fzf']],
      cmd = {'Files', 'Buffers', 'Rg'},
    }
    use { 'camspiers/snap',
      disable = false,
      config = [[require'modules/snap'.config()]],
      keys = {'<C-p>', '<C-f>', '<C-b>'},
    }
    use { 'nvim-telescope/telescope.nvim',
      disable = true,
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      setup = [[require'modules/telescope'.setup()]],
      config = [[require'modules/telescope'.config()]],
      cmd = {'Telescope'},
    }
    use { 'lukas-reineke/indent-blankline.nvim',
      setup = [[require'modules/indent_blankline']],
      event = 'BufRead',
    }
    use { 'kevinhwang91/nvim-bqf' }
    use { 'folke/which-key.nvim',
      config = [[require'modules/whichkey']],
    }
    use { 'simrat39/symbols-outline.nvim',
      setup = [[require'modules/outline']],
      cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}
    }

    -- Syntax highlight
    use 'chr4/nginx.vim'
    use { 'hashivim/vim-terraform',
      disable = true,
      config = [[require'modules/terraform']],
    }
    use 'robbles/logstash.vim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
      config = [[require'modules/treesitter']],
    }
    use { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter', }
    use { 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter', }
    use { 'nvim-treesitter/playground', after = 'nvim-treesitter', }

    -- Status
    use { 'hoob3rt/lualine.nvim', config = [[require'modules/lualine']] }
    use { "jose-elias-alvarez/buftabline.nvim",
      setup = [[require'modules/buftabline'.setup()]],
      config = [[require'modules/buftabline'.config()]],
    }

    -- Debugging
    use {'mfussenegger/nvim-dap',
      config = [[require'modules/debugging/dap']],
      keys = { "<F1>", "<F5>", "<F9>", "<F10>", "<F11>", "<F12>" },
    }
    use { 'rcarriga/nvim-dap-ui',
      requires = { localplug('installer') },
      config = [[require'modules/debugging/dapui']],
      after = {'nvim-dap'},
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      requires = { localplug('installer')},
      config = [[require'modules/lsp']],
    }
    use { 'nvim-lua/lsp-status.nvim', config = [[require'modules/lspstatus']] }
    use { 'hrsh7th/nvim-compe', config = [[require'modules/compe']], event = 'InsertEnter' }
    use { 'glepnir/lspsaga.nvim', config = [[require'modules/lspsaga']], cmd = 'Lspsaga' }
    use { 'ray-x/lsp_signature.nvim' }

    -- Snippets
    use { 'hrsh7th/vim-vsnip', after = 'nvim-compe' }
    use { 'hrsh7th/vim-vsnip-integ', after = 'vim-vsnip' }
  end,

  config = {
    compile_path = compile_path,
    profile = {
      threshold = 1,
    }
  },
})

