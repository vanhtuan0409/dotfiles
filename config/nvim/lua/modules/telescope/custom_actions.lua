local _M = {}
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function _M.multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    local cwd = picker.cwd
    if cwd == nil then
      cwd = ""
    else
      cwd = string.format("%s/", cwd)
    end
    vim.cmd("bw!") -- wipe prompt buffer

    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format(":e! %s%s", cwd, entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_edit(prompt_bufnr)
  end
end

return _M
