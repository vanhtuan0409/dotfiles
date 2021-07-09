local _M = {}

function _M.setup()
  vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<cr>", { silent=true, noremap = true})
  vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope live_grep<cr>", { silent=true, noremap = true})
  vim.api.nvim_set_keymap("n", "<C-b>", ":Telescope buffers<cr>", { silent=true, noremap = true})
end

function _M.config()
  local actions = require('telescope.actions')
  local action_state = require("telescope.actions.state")

  function multi_select(f)
    local consumer = function(bufnr)
      local picker = action_state.get_current_picker(bufnr)
      local num_selections = table.getn(picker:get_multi_selection())
      if num_selections > 1 then
        f(bufnr)
      else
        actions.file_edit(bufnr)
      end
    end
    return consumer
  end

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
    pickers = {
      find_files = {
        mappings = {
          n = {
            ["<CR>"] = multi_select(function(bufnr)
              actions.file_edit(bufnr)
            end)
          },
          i = {
            ["<CR>"] = multi_select(function(bufnr)
              actions.file_edit(bufnr)
            end)
          }
        }
      }
    }
  }
end

return _M
