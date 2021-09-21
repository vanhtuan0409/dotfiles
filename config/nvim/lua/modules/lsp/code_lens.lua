-- temporary port from nvim 0.6
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/codelens.lua#L99

local namespaces = vim.lsp.codelens.__namespaces -- access private field
local api = vim.api

local _old_display = vim.lsp.codelens.display

vim.lsp.codelens.display = function(lenses, bufnr, client_id)
  if not lenses or not next(lenses) then
    return
  end
  local lenses_by_lnum = {}
  for _, lens in pairs(lenses) do
    local line_lenses = lenses_by_lnum[lens.range.start.line]
    if not line_lenses then
      line_lenses = {}
      lenses_by_lnum[lens.range.start.line] = line_lenses
    end
    table.insert(line_lenses, lens)
  end
  local ns = namespaces[client_id]
  local num_lines = api.nvim_buf_line_count(bufnr)
  for i = 0, num_lines do
    local line_lenses = lenses_by_lnum[i] or {}
    api.nvim_buf_clear_namespace(bufnr, ns, i, i + 1)
    local chunks = {{' ', 'LspCodeLensSign'}}
    local num_line_lenses = #line_lenses
    for j, lens in ipairs(line_lenses) do
      local text = lens.command and lens.command.title or 'Unresolved lens ...'
      table.insert(chunks, {text, 'LspCodeLens' })
      if j < num_line_lenses then
        table.insert(chunks, {' | ', 'LspCodeLensSeparator' })
      end
    end
    if #chunks > 1 then
      api.nvim_buf_set_extmark(bufnr, ns, i, 0, { virt_text = chunks })
    end
  end
end
