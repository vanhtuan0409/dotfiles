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
  local schemas = getStatus(client, bufnr)
  schemas = vim.tbl_map(shortenLink, schemas)
  local status = table.concat(schemas, " | ")
  vim.b["jsonschema"] = status
end
