require'utils'.disable_builtins {
  "matchit", "spellfile_plugin", "fzf",
  "zip", "zipPlugin", "tar", "tarPlugin", "vimball", "vimballPlugin",
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "shada_plugin", "2html_plugin", "tutor_mode_plugin",
}

local localplug = function(plug)
  return LOCAL_PLUGS_PATH .. "/" .. plug
end

local packer = require'packer_init'

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
      config = [[require'installer'.setup()]]
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
      event = "InsertEnter",
    }
    use { 'wakatime/vim-wakatime', opt = true }
    use { 'lewis6991/gitsigns.nvim',
      opt = true,
      requires = {'nvim-lua/plenary.nvim'},
      config = [[require'modules/gitsigns']],
      setup = function()
        require("utils").packer_lazy_load("gitsigns.nvim")
      end,
    }
    use { 'folke/trouble.nvim',
      setup = [[require'modules/trouble'.setup()]],
      config = [[require'modules/trouble'.config()]],
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    }
    use { 'lukas-reineke/indent-blankline.nvim',
      config = [[require'modules/indent_blankline']],
      event = 'BufRead',
    }
    use { 'kevinhwang91/nvim-bqf',
      config = [[require'modules/bqf']],
    }
    use { 'folke/which-key.nvim',
      config = [[require'modules/whichkey']],
      opt = true,
    }
    use { 'simrat39/symbols-outline.nvim',
      setup = [[require'modules/outline']],
      cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}
    }
    use { 'norcalli/nvim-colorizer.lua',
      config = [[require'modules/colorizer']],
      event = 'BufRead',
    }
    use { 'andymass/vim-matchup',
      disable = true,
      opt = true,
      setup = function()
        require("utils").packer_lazy_load("vim-matchup")
      end
    }

    -- Syntax highlight
    use 'chr4/nginx.vim'
    use { 'hashivim/vim-terraform',
      disable = true,
      config = [[require'modules/terraform']],
    }
    use 'robbles/logstash.vim'

    -- Telescope
    use { 'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/plenary.nvim'}},
      setup = [[require'modules/telescope'.setup()]],
      config = [[require'modules/telescope'.config()]],
      cmd = {'Telescope'},
      module = "telescope"
    }
    use { 'nvim-telescope/telescope-dap.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension('dap')
      end,
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim',
      after = 'telescope.nvim',
      run = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
      config = [[require'modules/treesitter']],
    }
    use { 'windwp/nvim-ts-autotag' }
    use { 'RRethy/nvim-treesitter-textsubjects' }
    use { 'nvim-treesitter/playground' }
    use { 'SmiteshP/nvim-gps',
      config = [[require'modules/gps']],
    }

    -- Org mode
    use { 'nvim-neorg/neorg', branch = "unstable",
      config = [[require'modules/neorg']],
      requires = "nvim-lua/plenary.nvim",
    }

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
    use { 'neovim/nvim-lspconfig',
      opt = true,
      config = [[require'modules/lsp']],
      setup = function()
        require("utils").packer_lazy_load("nvim-lspconfig")
        vim.defer_fn(function()
          if vim.bo.filetype ~= "packer" then
            vim.cmd "silent! e %"
          end
        end, 0)
      end,
    }
    use { 'nvim-lua/lsp-status.nvim', config = [[require'modules/lspstatus']],
      after = 'nvim-lspconfig',
    }
    use { 'ray-x/lsp_signature.nvim',
      after = {'nvim-lspconfig'},
      config = [[require'modules/lspsignature']]
    }
    use { 'jose-elias-alvarez/null-ls.nvim',
      after = {'nvim-lspconfig'},
      config = [[require'modules/nullls']]
    }
    use { 'hrsh7th/nvim-cmp',
      wants = { 'LuaSnip' },
      config = [[require'modules/cmp']], 
      event = "InsertEnter",
      module = "cmp",
    }

    -- Cmp sources
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  end,
})

