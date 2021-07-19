local _M = {}
local vimp = require("vimp")

function _M.setup()
  vimp.nnoremap("<C-p>", ":Telescope find_files<cr>")
  vimp.nnoremap("<C-f>", ":Telescope live_grep<cr>")
  vimp.nnoremap("<C-b>", ":Telescope buffers<cr>")
end

function _M.config()
  vim.cmd [[highlight TelescopeMultiSelection guifg=#d8a657 gui=bold]]

  local actions = require('telescope.actions')
  local action_state = require("telescope.actions.state")
  require('telescope').setup{
    defaults = {
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
    pickers = {}
  }
end

return _M
