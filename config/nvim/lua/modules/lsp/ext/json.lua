local M = {}
local ns = vim.api.nvim_create_namespace('jsonschema')

function getStatus(client, bufnr)
  local params = vim.uri_from_bufnr(bufnr)
  local result = client.request_sync("json/languageStatus", params, 200, bufnr) or {}
  result = result.result or {}
  local schemas = result.schemas
  return schemas[1]
end

function M.on_attach(client, bufnr)
  local schema = getStatus(client, bufnr)
  if schema ~= nil then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, 1)
    vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 1, {
      virt_text = {{schema, 'LspCodeLens'}},
    })
  end
end

return M
