local M = {}

function M.gruvbox()
  vim.opt.background = 'dark'
  vim.g.gruvbox_material_enable_italic = true
  vim.g.gruvbox_material_better_performance = true
  vim.cmd('colorscheme gruvbox-material')
end

function M.everforest()
  vim.opt.background = 'dark'
  vim.g.everforest_background = 'hard'
  vim.g.everforest_ui_contrast = 'high'
  vim.g.everforest_enable_italic = true
  vim.g.everforest_better_performance = true
  vim.cmd('colorscheme everforest')
end

function M.melange()
  vim.opt.background = 'dark'
  vim.cmd('colorscheme melange')
end

function M.kanagawa()
  vim.opt.background = 'dark'
  vim.cmd('colorscheme kanagawa')
end

return M
