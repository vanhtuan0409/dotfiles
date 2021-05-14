local _M = {}

function _M.setup()
  vim.api.nvim_set_keymap("n", "<leader>d", ":Trouble<cr>", { silent=true, noremap = true})
end

function _M.config()
  require'trouble'.setup {
    height = 8,
    icons = false,
    mode = "lsp_document_diagnostics",
    action_keys = {
      close = { 'q', '<C-d>' },
    },
  }
end

return _M
