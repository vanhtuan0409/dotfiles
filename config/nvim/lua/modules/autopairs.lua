local npairs = require'nvim-autopairs'
npairs.setup()

if require("utils").prequire("cmp") then
  require'nvim-autopairs.completion.cmp'.setup({
    map_complete = true,
    map_cr = true,
  })
end
