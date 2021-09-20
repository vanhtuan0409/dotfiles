-- LSP on attach
local _M = {}
local npcall = vim.F.npcall

function c_show_line_diagnostics()
  -- Dont show diagnostic if another preview windows is showing
  local existing_float = npcall(vim.api.nvim_buf_get_var, bufnr, "lsp_floating_preview")
  if existing_float and vim.api.nvim_win_is_valid(existing_float) then
    return
  end

  vim.lsp.diagnostic.show_line_diagnostics({
    border='single',
    focusable=false,
    show_header=false,
    close_events = {
      "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", -- default
      "BufLeave",
    },
  })
end

local set_buf_keymap = function(bufnr)
  vim.cmd [[command! Formatting call v:lua.vim.lsp.buf.formatting_sync()]]
  -- vim.cmd [[autocmd CursorHold  * :Lspsaga show_line_diagnostics]]
  vim.cmd [[autocmd CursorHold  * lua c_show_line_diagnostics()]]

  local vimp = require("vimp")
  vimp.add_buffer_maps(bufnr, function()
    -- vimp.nnoremap({'silent'}, 'K', [[:Lspsaga hover_doc<CR>]])
    vimp.nnoremap({'silent'}, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

    -- vimp.nnoremap({'silent'}, 'gh', [[:Lspsaga lsp_finder<CR>]])
    
    -- vimp.nnoremap({'silent'}, '<leader>rn',[[:Lspsaga rename<CR>]])
    vimp.nnoremap({'silent'}, '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    
    -- vimp.nnoremap({'silent'}, '<leader>ga', [[:Lspsaga code_action<CR>]])
    vimp.nnoremap({'silent'}, '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')

    vimp.nnoremap({'silent'}, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  end)
end

function _M.default(client, bufnr)
  set_buf_keymap(bufnr)

  -- auto format
  require'modules/lsp/utils'.auto_formatting(client)
  require'modules/lsp/utils'.auto_codelenses(client)


  -- Emit user event
  vim.cmd [[ doautocmd User LspAttached ]]
end

function _M.make_on_attach(opts)
  local opts = opts or {}
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
