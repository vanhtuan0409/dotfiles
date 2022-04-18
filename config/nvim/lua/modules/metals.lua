local metals_setup = function()
  vim.opt.shortmess:remove "F"

  local metals = require("metals")
  local attach = require'modules/lsp/on_attach'
  require('telescope').load_extension('metals')

  metals_config = require("metals").bare_config()
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    serverProperties = {
      "-Xms8G",
      "-Xmx12G",
    }
  }
  metals_config.on_attach = function(client, bufnr)
    attach.make_on_attach()(client, bufnr)
    metals.setup_dap()
  end

  require("metals").initialize_or_attach(metals_config)
end

local metals_ag = vim.api.nvim_create_augroup("MetalsLSP", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = metals_ag,
  pattern = { "scala", "sbt" },
  callback = function(params)
    metals_setup()
  end,
})
