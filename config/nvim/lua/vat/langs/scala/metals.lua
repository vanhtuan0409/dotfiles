local M = {}

local function check_script_file(file_name)
	local pwd = vim.fn.getcwd()
	local checkScript = pwd .. "/" .. file_name
	if vim.fn.filereadable(checkScript) == 1 then
		return checkScript
	end
	return ""
end

function M.get_config()
	local metals = require("metals")
	local scfg = require("vat.modules2.lsp.server_config")
	local metals_config = metals.bare_config()
	metals_config.init_options.statusBarProvider = "off"
	metals_config.settings = {
		sbtScript = check_script_file("sbt"),
		millScript = check_script_file("mill"),
		showImplicitArguments = true,
		showInferredType = true,
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}
	metals_config.on_attach = function(client, bufnr)
		scfg.on_attach(client, bufnr)
		scfg.toggle_codelens(client, true)
		metals.setup_dap()
	end

	return metals_config
end

function M.start_metals(config)
	-- check for within stargazer
	local buf_path = vim.fn.expand("%:p")
	if string.find(buf_path, "stargazer") then
		return
	end
	M.force_start_metals(config)
end

function M.force_start_metals(config)
	vim.opt.shortmess:remove("F")

	local metals = require("metals")
	metals.initialize_or_attach(config)
end

return M
