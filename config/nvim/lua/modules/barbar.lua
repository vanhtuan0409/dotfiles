local M = {}

function M.setup()
  vim.g.bufferline = {
    animation = false,
    icons = false,
    clickable = false,
    closable = false,
    maximum_padding = 2,
  }

  -- make Bonly alias
  vim.cmd([[command! Bonly BufferCloseAllButCurrent]])

  -- Key mapping
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<C-d>', ":BufferClose<CR>", opts)
  vim.api.nvim_set_keymap('n', '<C-w>', ":bufdo :BufferClose<CR>", opts)
  vim.api.nvim_set_keymap('n', '<Tab>', ":BufferNext<CR>", opts)
  vim.api.nvim_set_keymap('n', '<S-Tab>', ":BufferPrevious<CR>", opts)
end

function M.config()
  -- Custom highlight
  vim.cmd([[highlight BufferCurrent guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentIndex guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentMod guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentSign guifg=#a89984 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentTarget guifg=#000000 guibg=#a89984]])
end

return M
