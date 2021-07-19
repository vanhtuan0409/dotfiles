local M = {}
local vimp = require("vimp")

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
  vimp.nnoremap('<C-d>', ":BufferClose<CR>")
  vimp.nnoremap('<C-w>', ":bufdo :BufferClose<CR>")
  vimp.nnoremap('<Tab>', ":BufferNext<CR>")
  vimp.nnoremap('<S-Tab>', ":BufferPrevious<CR>")
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
