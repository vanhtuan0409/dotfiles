local M = {}

function M.gruvbox()
  vim.g.gruvbox_material_enable_italic = true
  vim.g.gruvbox_material_better_performance = true
  vim.cmd('colorscheme gruvbox-material')
end

return M
