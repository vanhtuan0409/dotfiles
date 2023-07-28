local M = {}
local global_config = nil
local status = require("langs.scala.status")

local function get_config()
	local metals = require("metals")
	local scfg = require("modules2.lsp.server_config")
	local sbtScript = ""
	local pwd = vim.fn.getcwd()
	local checkSbtScript = pwd .. "/sbt"
	if vim.fn.filereadable(checkSbtScript) == 1 then
		sbtScript = checkSbtScript
	end

	local metals_config = metals.bare_config()
	metals_config.init_options.statusBarProvider = "on"
	metals_config.settings = {
		sbtScript = sbtScript,
		serverVersion = "1.0.0",
		bloopVersion = "1.5.9",
		showImplicitArguments = true,
		showInferredType = true,
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}
	metals_config.handlers["metals/status"] = status.handler
	metals_config.on_attach = function(client, bufnr)
		scfg.on_attach(client, bufnr, true)
		metals.setup_dap()
	end

	return metals_config
end

local function start_metals(config)
	vim.opt.shortmess:remove("F")
	require("telescope").load_extension("metals")

	local metals = require("metals")
	metals.initialize_or_attach(config)
end

function M.init()
	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt" },
		callback = function()
			if not global_config then
				global_config = get_config()
			end
			start_metals(global_config)
		end,
		group = nvim_metals_group,
	})
end

return M
