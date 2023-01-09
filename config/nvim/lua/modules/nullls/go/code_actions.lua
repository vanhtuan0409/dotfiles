local M = {}
local helpers = require("modules.nullls.helpers")
local installer = require('installer')

local extract_struct_name = function(params)
  local linenr = params.row
  local line = params.content[linenr]
  return line:match('^type (.*) struct')
end

M.gostructhelper = helpers.make_code_action({
  name = "gostructhelper",
  filetypes = {"go"},
  action_fn = function(params)
    local typ = extract_struct_name(params)
    if not typ then
      return
    end

    local command = installer.bin("gostructhelper")
    local actions = {
      {
        title = "[gostructhelper] Generate constructor",
        command = command,
        stdin = true,
        args = {"-stdin", "-file", params.bufname, "-type", typ, "-constructor"},
        on_output = helpers.replace_buf,
      },
      {
        title = "[gostructhelper] Generate getter",
        command = command,
        stdin = true,
        args = {"-stdin", "-file", params.bufname, "-type", typ, "-getter"},
        on_output = helpers.replace_buf,
      },
    }
    return actions
  end,
})

return M
