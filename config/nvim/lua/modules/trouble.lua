local _M = {}

function _M.setup()
  require"vimp".nnoremap("<leader>d", ":TroubleToggle<cr>")
end

function _M.config()
  require'trouble'.setup {
    height = 8,
    icons = false,
    mode = "document_diagnostics",
    action_keys = {
      close = { 'q', '<C-d>' },
    },
  }
end

return _M
