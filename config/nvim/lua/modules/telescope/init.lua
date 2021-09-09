local _M = {}
local vimp = require("vimp")

function _M.setup()
  vimp.nnoremap("<C-p>", ":Telescope find_files<cr>")
  vimp.nnoremap("<C-f>", ":Telescope live_grep<cr>")
  vimp.nnoremap("<C-b>", ":Telescope buffers<cr>")
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
      file_ignore_patterns = {".git/"},
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
      },
    },
  }
end

return _M
