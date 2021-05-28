local _M = {}

function _M.setup()
  vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<cr>", { silent=true, noremap = true})
  vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope live_grep<cr>", { silent=true, noremap = true})
  vim.api.nvim_set_keymap("n", "<C-b>", ":Telescope buffers<cr>", { silent=true, noremap = true})
end

function _M.config()
  local actions = require('telescope.actions')
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      }
    }
  }
end

return _M
