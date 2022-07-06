require("nvim-navic").setup({})

if vim.fn.has("nvim-0.8") == 1 then
  vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end
