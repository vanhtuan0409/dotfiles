local npairs = require'nvim-autopairs'
npairs.setup()

if require("utils").prequire("cmp") then
  require'nvim-autopairs.completion.cmp'.setup({
    map_cr = true,
    auto_select = false,
  })
end
