local ns = vim.api.nvim_create_namespace('jsonschema')

local function getStatus(client, bufnr)
  local params = vim.uri_from_bufnr(bufnr)
  local result = client.request_sync("json/languageStatus", params, 200, bufnr) or {}
  result = result.result or {}
  return result.schemas or {}
end

local function shortenLink(schema)
  return string.gsub(schema, "https://json.schemastore.org/", "store://")
end

return function(client, bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, 1)
  local schemas = getStatus(client, bufnr)
  local count = #schemas

  local chunks = {}
  for i = 1, count do
    local schema = schemas[i] or {}
    table.insert(chunks, {shortenLink(schema), "LspCodeLens"})
    if i < count then
      table.insert(chunks, {' | ', "LspCodeLensSeparator"})
    end
  end

  if #chunks > 0 then
    vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 1, {
      virt_text = chunks,
    })
  end

end
