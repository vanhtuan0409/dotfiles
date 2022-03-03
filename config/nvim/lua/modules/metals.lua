function metals_setup()
  require("metals").initialize_or_attach({})
end

vim.cmd [[
augroup metals
  au!
  au FileType scala,sbt call v:lua.metals_setup()
augroup end
]]
