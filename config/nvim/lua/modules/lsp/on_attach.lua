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

local set_buf_keymap = function(client, bufnr)
  vim.api.nvim_create_user_command("Formatting", function(params)
    vim.lsp.buf.formatting_seq_sync(nil, 200)
  end, { bang = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function(params)
      c_show_line_diagnostics()
    end,
  })

  require("utils").keymap_set_multi("n", {
    ["K"]             = vim.lsp.buf.hover,
    ["<leader>rn"]    = vim.lsp.buf.rename,
    ["gd"]            = vim.lsp.buf.definition,
    ["gi"]            = vim.lsp.buf.implementation,
    ["gr"]            = vim.lsp.buf.references,
    ["gy"]            = vim.lsp.buf.type_definition,
    ["<leader>f"]     = vim.lsp.buf.formatting,
    ["<leader>ga"]    = vim.lsp.buf.code_action,
  }, { silent = true, buffer = bufnr })
end

function _M.default(client, bufnr)
  set_buf_keymap(client, bufnr)

  -- auto format
  require'modules.lsp.utils'.auto_formatting(client, bufnr)
  -- require'modules.lsp.utils'.auto_codelenses(client, bufnr)

  -- Emit user event
  vim.cmd [[ doautocmd User LspAttached ]]
end

function _M.make_on_attach(opts)
  opts = opts or {}
  return function(client, bufnr)
    for cap, enabled in pairs(opts) do
      if not enabled then
        -- for post 0.7
        client.server_capabilities[cap] = false
        -- for 0.7 and pre 0.7
        client.resolved_capabilities[cap] = false
      end
    end
    _M.default(client, bufnr)
  end
end

return _M
