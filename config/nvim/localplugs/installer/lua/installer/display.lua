local M = {}

local buf, win
local tool_marks = {}
local ns = vim.api.nvim_create_namespace('')

local set_mappings = function ()
  local mappings = {
    ['q'] = ':bdelete<CR>',
    ['<C-d>'] = ':bdelete<CR>',
  }

  local opts = {nowait = true, noremap = true, silent = true}
  for k,v in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(buf, 'n', k, v, opts)
  end
end

local create_win = function()
  vim.api.nvim_command('topleft vnew') -- We open a new vertical window at the far right
  win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
  buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, {'Installer'})

  vim.api.nvim_buf_set_name(buf, 'Installer')
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'installer')

  -- For better UX we will turn off line wrap and turn on current line highlight.
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  set_mappings() -- At end we will set mappings for our navigation.
end

function M.create_win_if_needed()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
  else
    create_win()
  end
end

function M.set_tool_msg(tool)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  local max_line = vim.api.nvim_buf_line_count(buf)
  local msg = '[ ] ' .. tool
  vim.api.nvim_buf_set_lines(buf, max_line, -1, true, {msg})
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  local id = tool_marks[tool] or nil
  tool_marks[tool] = vim.api.nvim_buf_set_extmark(buf, ns, max_line, 0, { id = id })
end

function M.set_tool_result(tool, rcode)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  local line, _ = unpack(vim.api.nvim_buf_get_extmark_by_id(buf, ns, tool_marks[tool], {}))
  if rcode == 0 then
    vim.api.nvim_buf_set_text(buf, line, 1, line, 2, { 'v' })
  else
    vim.api.nvim_buf_set_text(buf, line, 1, line, 2, { 'x' })
  end
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

return M
