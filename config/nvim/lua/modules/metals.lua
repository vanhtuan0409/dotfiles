local metals = require("metals")
local attach = require'modules.lsp.on_attach'

local function start_metals()
  vim.opt.shortmess:remove "F"
  require('telescope').load_extension('metals')

  local metals_config = metals.bare_config()
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    serverProperties = {
      "-Xms8G",
      "-Xmx12G",
    }
  }

  local handler = attach.make_on_attach()
  metals_config.on_attach = function(client, bufnr)
    handler.on_attach(client, bufnr)
    metals.setup_dap()
  end

  metals.initialize_or_attach(metals_config)
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = nvim_metals_group,
  pattern = { "scala", "sbt" },
  callback = start_metals,
})
