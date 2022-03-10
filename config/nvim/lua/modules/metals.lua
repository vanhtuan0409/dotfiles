function metals_setup()
  vim.opt.shortmess:remove "F"

  local metals = require("metals")
  local attach = require'modules/lsp/on_attach'
  local sbtScript = ""
  local pwd = vim.fn.getcwd()
  local stargazer = ANDUIN_PATH .. "/stargazer"
  local forkedStargazer = ANDUIN_PATH .. "/forked-stargazer"
  if vim.startswith(pwd, stargazer) then
    sbtScript = stargazer .. "/sbt"
  elseif vim.startswith(pwd, forkedStargazer) then
    sbtScript = forkedStargazer .. "/sbt"
  end

  metals_config = require("metals").bare_config()
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {
    sbtScript = sbtScript,
    serverProperties = {
      "-Xms750m",
      "-Xmx5G",
    }
  }
  metals_config.on_attach = function(client, bufnr)
    attach.make_on_attach()(client, bufnr)
    metals.setup_dap()
  end

  require("metals").initialize_or_attach(metals_config)
end

vim.cmd [[
augroup metals
  au!
  au FileType scala,sbt call v:lua.metals_setup()
augroup end
]]
