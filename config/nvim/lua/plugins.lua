vim.g.loaded_matchit = true
vim.g.loaded_fzf = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_gzip = true
vim.g.loaded_shada_plugin = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_tutor_mode_plugin = true

local execute = vim.api.nvim_command
local fn = vim.fn

local localplug = function(plug)
  return LOCAL_PLUGS_PATH .. "/" .. plug
end

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
packer.startup({
  function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    -- Lib
    use { 'svermeulen/vimpeccable', config = function()
      require'vimp'.always_override = true
    end}

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
      after = 'nvim-cmp',
    }
    use { 'wakatime/vim-wakatime', opt = true }
    use { 'lewis6991/gitsigns.nvim',
      opt = true,
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'modules/gitsigns']],
      setup = function()
        require("utils").packer_lazyload("gitsigns.nvim")
      end,
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
      opt = true,
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
      branch = "0.5-compat",
      config = [[require'modules/treesitter']],
      event = 'BufRead',
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
      setup = [[require'modules/debugging/dap'.setup()]],
      config = [[require'modules/debugging/dap'.config()]],
    }
    use { 'rcarriga/nvim-dap-ui',
      config = [[require'modules/debugging/dapui']],
      after = {'nvim-dap'},
    }

    -- Snippets
    use { 'L3MON4D3/LuaSnip',
      config = [[require'modules/luasnip']],
      opt = true,
    }

    -- LSP
    use { 'nvim-lua/lsp-status.nvim', config = [[require'modules/lspstatus']], opt = true }
    use { 'ray-x/lsp_signature.nvim', opt = true }
    use { 'neovim/nvim-lspconfig',
      wants = { 'lsp-status.nvim', 'lsp_signature.nvim', 'cmp-nvim-lsp' },
      config = [[require'modules/lsp']],
      event = 'BufReadPre',
    }
    use { 'jose-elias-alvarez/null-ls.nvim',
      after = {'nvim-lspconfig'},
      config = [[require'modules/lsp/nullls']]
    }
    use { 'hrsh7th/nvim-cmp',
      wants = { 'LuaSnip' },
      config = [[require'modules/cmp']], 
      event = "InsertEnter",
    }
    use { 'glepnir/lspsaga.nvim', config = [[require'modules/lspsaga']], cmd = 'Lspsaga' }

    -- Cmp sources
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  end,

  config = {
    compile_path = PACKER_COMPILED_PATH,
    profile = {
      threshold = 1,
    }
  },
})

