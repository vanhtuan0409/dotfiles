local M = {}
local helpers = require("modules/nullls/helpers")
local installer = require('installer')

local extract_struct_name = function(params)
  local linenr = params.row
  local line = params.content[linenr]
  return line:match('^type (.*) struct')
end

local prompt_tag_name = function()
  local available_tags = {"json", "db", "env"}
  local options = {"Select struct tag:"}
  for i, tag in ipairs(available_tags) do
    table.insert(options, string.format("%d. %s", i, tag))
  end
  local choice = vim.fn.inputlist(options)
  if choice < 1 or choice > #available_tags then
    return
  end
  return available_tags[choice]
end

M.gostructhelper = helpers.make_code_action({
  name = "gostructhelper",
  filetypes = {"go"},
  action_fn = function(params)
    local typ = extract_struct_name(params)
    if not typ then
      return
    end

    local command = "gostructhelper"
    local actions = {
      {
        title = "[gostructhelper] Generate constructor",
        command = command,
        stdin = true,
        args = {"-stdin", "-file", params.bufname, "-type", typ, "-constructor"},
      },
      {
        title = "[gostructhelper] Generate getter",
        command = command,
        stdin = true,
        args = {"-stdin", "-file", params.bufname, "-type", typ, "-getter"},
      },
    }
    return actions
  end,
})

M.gomodifytags = helpers.make_code_action({
  name = "gomodifytags",
  filetypes = {"go"},
  action_fn = function(params)
    local typ = extract_struct_name(params)
    if not typ then
      return
    end

    local command = installer.bin("gomodifytags")
    local actions = {
      {
        title = "[gomodifytags] Add struct tags",
        callback = function(invoke_cli)
          local tag = prompt_tag_name()
          if not tag then
            return
          end
          invoke_cli({
            command = command,
            args = {"-file", params.bufname, "-struct", typ, "-skip-unexported", "-add-tags", tag},
          })
        end,
      },
      {
        title = "[gomodifytags] Remove struct tags",
        callback = function(invoke_cli)
          local tag = prompt_tag_name()
          if not tag then
            return
          end
          invoke_cli({
            command = command,
            args = {"-file", params.bufname, "-struct", typ, "-skip-unexported", "-remove-tags", tag},
          })
        end,
      },
      {
        title = "[gomodifytags] Clear struct tags",
        command = command,
        args = {"-file", params.bufname, "-struct", typ, "-skip-unexported", "-clear-tags"},
      },
    }
    return actions
  end,
})

return M
