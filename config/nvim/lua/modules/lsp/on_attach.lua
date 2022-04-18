-- LSP on attach
local _M = {}
local npcall = vim.F.npcall

local c_show_line_diagnostics = function()
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
  vim.api.nvim_create_user_command("Formatting", function(params)
    vim.lsp.buf.formatting_seq_sync(nil, 200)
  end, { bang = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function(params)
      c_show_line_diagnostics()
    end,
  })

  local keymap_opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, keymap_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, keymap_opts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, keymap_opts)
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
