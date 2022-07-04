-- LSP on attach
local set_buf_keymap = function(client, bufnr)
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

function make_on_attach(opts)
  opts = opts or {}
  local handler = {
    caps = opts.caps or {},
    middlewares = opts.middlewares or {
      require'modules.lsp.ext.auto_formatting'.on_attach,
      require'modules.lsp.ext.auto_codelenses'.on_attach,
      require'modules.lsp.ext.auto_codeaction'.on_attach,
      require'modules.lsp.ext.auto_diagnostic'.on_attach,
    },
  }

  handler.with = function(user_opts)
    return make_on_attach({
      caps = vim.tbl_extend("force", handler.caps, user_opts.caps or {}),
      middlewares = vim.tbl_flatten({ handler.middlewares, user_opts.middlewares or {}}),
    })
  end

  handler.on_attach = function(client, bufnr)
    for cap, enabled in pairs(handler.caps) do
      if not enabled then
        client.server_capabilities[cap] = false
        client.resolved_capabilities[cap] = false
      end
    end

    set_buf_keymap(client, bufnr)

    for _, mdw in pairs(handler.middlewares) do
      mdw(client, bufnr)
    end

    -- Emit user event
    vim.cmd [[ doautocmd User LspAttached ]]
  end

  return handler
end

return {
  make_on_attach = make_on_attach,
}
