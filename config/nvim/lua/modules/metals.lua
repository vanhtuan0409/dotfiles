local metals = require("metals")
local attach = require'modules.lsp.on_attach'
require('telescope').load_extension('metals')

vim.opt.shortmess:remove "F"

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
