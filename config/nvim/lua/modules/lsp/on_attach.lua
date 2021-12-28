-- LSP on attach
local _M = {}
local npcall = vim.F.npcall

function c_show_line_diagnostics()
  -- Dont show diagnostic if another preview windows is showing
  local existing_float = npcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_preview")
  if existing_float and vim.api.nvim_win_is_valid(existing_float) then
    return
  end

  vim.diagnostic.open_float(nil, {
    source='always',
    border='single',
    focusable=false,
    close_events = {
      "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", -- default
      "BufLeave", "FocusLost",
    },
  })
end

local set_buf_keymap = function(bufnr)
  vim.cmd [[command! Formatting call v:lua.vim.lsp.buf.formatting_sync()]]
  vim.cmd [[autocmd CursorHold  * lua c_show_line_diagnostics()]]

  local vimp = require("vimp")
  vimp.add_buffer_maps(bufnr, function()
    vimp.nnoremap({'silent'}, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vimp.nnoremap({'silent'}, '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vimp.nnoremap({'silent'}, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vimp.nnoremap({'silent'}, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vimp.nnoremap({'silent'}, 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vimp.nnoremap({'silent'}, 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vimp.nnoremap({'silent'}, '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  end)
end

function _M.default(client, bufnr)
  set_buf_keymap(bufnr)

  -- auto format
  require'modules/lsp/utils'.auto_formatting(client)
  -- require'modules/lsp/utils'.auto_codelenses(client)

  -- Emit user event
  vim.cmd [[ doautocmd User LspAttached ]]
end

function _M.make_on_attach(opts)
  opts = opts or {}
  return function(client, bufnr)
    for cap, enabled in pairs(opts) do
      if not enabled then
        client.resolved_capabilities[cap] = false
      end
    end
    _M.default(client, bufnr)
  end
end

return _M
