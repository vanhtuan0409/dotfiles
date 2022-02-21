local _M = {}
local vimp = require("vimp")

function _M.setup()
  vimp.nnoremap("<C-p>", ":Telescope find_files<cr>")
  vimp.nnoremap("<C-f>", ":Telescope live_grep<cr>")
  vimp.nnoremap("<C-b>", ":Telescope buffers<cr>")
  vimp.nnoremap("<leader>ga", ":Telescope lsp_code_actions<cr>")
  vimp.nnoremap("<leader>t", ":Telescope<cr>")
end

function _M.config()
  local actions = require('telescope.actions')
  local custom_actions = require('modules/telescope/custom_actions')

  require('telescope').setup{
    defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
         "--hidden",
      },
      sorting_strategy = "ascending",
      file_ignore_patterns = {
        ".git/", "node_modules/", "target/", "bin/", "vendor/",
        "build/", ".terraform/",
      },
      mappings = {
        n = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      }
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = true,
        follow = true,
        mappings = {
          n = {
            ["<CR>"] = custom_actions.multi_select,
          },
          i = {
            ["<CR>"] = custom_actions.multi_select,
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    },
  }
end

return _M
