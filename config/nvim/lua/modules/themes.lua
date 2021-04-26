local M = {}

function M.setup()
  vim.g.gruvbox_material_enable_italic = true
  vim.g.gruvbox_material_better_performance = true
end

function M.config()
  vim.cmd('colorscheme gruvbox-material')
end

return M
