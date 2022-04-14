local M = {}

function M.gruvbox()
  vim.g.background = 'dark'
  vim.g.gruvbox_material_enable_italic = true
  vim.g.gruvbox_material_better_performance = true
  vim.cmd('colorscheme gruvbox-material')
end

function M.everforest()
  vim.g.background = 'dark'
  vim.g.everforest_background = 'hard'
  vim.g.everforest_enable_italic = true
  vim.g.everforest_better_performance = true
  vim.cmd('colorscheme everforest')
end

return M
