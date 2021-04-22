return function()
  vim.g.bufferline = {
    animation = false,
    icons = false,
    clickable = false,
    closable = false,
    icon_close_tab = "",
    icon_close_tab_modified = "",
    maximum_padding = 2,
  }

  -- make Bonly alias
  vim.cmd([[command! Bonly BufferCloseAllButCurrent]])

  -- Key mapping
  local opt = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<C-d>', ":BufferClose<CR>", opt)
  vim.api.nvim_set_keymap('n', '<C-w>', ":bufdo :BufferClose<CR>", opt)
  vim.api.nvim_set_keymap('n', '<Tab>', ":BufferNext<CR>", opt)
  vim.api.nvim_set_keymap('n', '<S-Tab>', ":BufferPrevious<CR>", opt)

  vim.cmd([[highlight BufferCurrent guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentIndex guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentMod guifg=#000000 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentSign guifg=#a89984 guibg=#a89984]])
  vim.cmd([[highlight BufferCurrentTarget guifg=#000000 guibg=#a89984]])
end
