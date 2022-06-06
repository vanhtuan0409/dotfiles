local _M = {}

function _M.setup()
  require("utils").keymap_set_multi("n", {
    ["<C-p>"]       = ":FzfLua files<CR>",
    ["<C-f>"]       = ":FzfLua live_grep<CR>",
  })
end

function _M.config()
  local actions = require "fzf-lua.actions"

  require('fzf-lua').setup{
    actions = {
      files = {
        ["default"] = actions.file_edit,
      }
    },
  }
end

return _M
