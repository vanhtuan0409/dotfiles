require'utils'.disable_builtins {
  "matchit", "spellfile_plugin", "fzf",
  "zip", "zipPlugin", "tar", "tarPlugin", "vimball", "vimballPlugin",
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "2html_plugin", "tutor", "tutor_mode_plugin", "rplugin", "rrhelper",
  "node_provider", "perl_provider", "python3_provider", "ruby_provider", "bugreport",
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
    use { 'nvim-lua/plenary.nvim' }
    use { 'b0o/schemastore.nvim',
      module = "schemastore",
    }

    -- Installer
    use { localplug("installer"),
      config = [[require'installer'.setup()]]
    }

    -- Themes
    use { 'sainnhe/gruvbox-material',
      config = [[require'modules.themes'.gruvbox()]]
    }
    use { 'savq/melange',
      -- config = [[require'modules.themes'.melange()]]
    }

    -- Enhancement
    use { localplug("winbar-breadcrumb"),
      config = [[require'modules.breadcrumb']]
    }
    use { 'is0n/fm-nvim',
      setup = [[require'modules.fm'.setup()]],
      config = [[require'modules.fm'.config()]],
      cmd = { "Broot" },
    }
    use { 'tpope/vim-commentary', event = 'BufRead' }
    use { 'kylechui/nvim-surround',
      config = [[require'modules.surround']],
      event = 'BufRead',
    }
    use { 'windwp/nvim-autopairs',
      config = [[require'modules.autopairs']],
      event = "InsertEnter",
    }
    use { 'lewis6991/gitsigns.nvim',
      config = [[require'modules.gitsigns']],
      event = "BufRead",
    }
    use { 'folke/trouble.nvim',
      setup = [[require'modules.trouble'.setup()]],
      config = [[require'modules.trouble'.config()]],
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    }
    use { 'lukas-reineke/indent-blankline.nvim',
      config = [[require'modules.indent_blankline']],
      event = 'BufRead',
    }
    use { 'kevinhwang91/nvim-bqf',
      config = [[require'modules.bqf']],
    }
    use { 'simrat39/symbols-outline.nvim',
      setup = [[require'modules.outline'.setup()]],
      config = [[require'modules.outline'.config()]],
      cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}
    }
    use { 'norcalli/nvim-colorizer.lua',
      config = [[require'modules.colorizer']],
      event = 'BufRead',
    }
    use { 'antoinemadec/FixCursorHold.nvim' }

    -- Syntax highlight
    use { 'chr4/nginx.vim',
      opt = true,
    }

    -- Telescope
    use { 'nvim-telescope/telescope.nvim',
      config = [[require'modules.telescope']],
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
    use { 'nvim-telescope/telescope-ui-select.nvim',
      after = 'telescope.nvim',
      config = function()
        require('telescope').load_extension('ui-select')
      end,
    }

    -- FZF
    use { 'ibhagwan/fzf-lua',
      config = [[require'modules.fzf']],
    }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
      config = [[require'modules.treesitter']],
    }
    use { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }
    use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }

    -- Status
    use { 'hoob3rt/lualine.nvim', config = [[require'modules.lualine']] }

    -- Debugging
    use {'mfussenegger/nvim-dap',
      setup = [[require'modules.debugging.dap'.setup()]],
      config = [[require'modules.debugging.dap'.config()]],
    }
    use { 'rcarriga/nvim-dap-ui',
      config = [[require'modules.debugging.dapui']],
      after = {'nvim-dap'},
    }

    -- Snippets
    use { 'L3MON4D3/LuaSnip',
      config = [[require'modules.luasnip']],
      opt = true,
    }

    -- LSP
    use { 'neovim/nvim-lspconfig',
      config = [[require'modules.lsp']],
    }
    use{ 'scalameta/nvim-metals',
      config = [[require'modules.metals']],
    }
    use { 'jose-elias-alvarez/null-ls.nvim',
      after = {'nvim-lspconfig'},
      config = [[require'modules.nullls']]
    }
    use { 'hrsh7th/nvim-cmp',
      wants = { 'LuaSnip' },
      config = [[require'modules.cmp']],
      event = "InsertEnter",
      module = "cmp",
    }
    use { 'kosayoda/nvim-lightbulb',
      config = [[require'modules.lightbulb']],
      module = 'nvim-lightbulb',
    }
    use { 'SmiteshP/nvim-navic',
      config = [[require'modules.navic']],
      module = 'nvim-navic',
    }
    use { 'kevinhwang91/nvim-ufo',
      requires = 'kevinhwang91/promise-async',
      config = [[require'modules.ufo']],
      event = 'BufRead',
    }

    -- Cmp sources
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
  end,
})
