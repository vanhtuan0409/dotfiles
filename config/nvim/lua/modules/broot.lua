local M = {}

function M.setup()
  vim.keymap.set("n", "<Space><Space>", ':Broot %:p<CR>')
end

function M.config()
  require("broot").setup({})
end

return M
