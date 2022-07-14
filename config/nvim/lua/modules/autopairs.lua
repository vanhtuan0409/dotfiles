local npairs = require'nvim-autopairs'
npairs.setup({
  check_ts = true,
})

local cmp = require("utils").prequire("cmp")
if cmp then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
