local npairs = require'nvim-autopairs'
npairs.setup()

function _G.input_confirm()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

vim.g.completion_confirm_key = ""
require"vimp".inoremap({'expr', 'silent'}, "<CR>", 'v:lua.input_confirm()')
