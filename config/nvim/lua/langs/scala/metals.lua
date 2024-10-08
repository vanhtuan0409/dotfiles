local M = {}
local global_config = nil
local status = require("langs.scala.status")
local utils = require("utils")

local function check_script_file(file_name)
	local pwd = vim.fn.getcwd()
	local checkScript = pwd .. "/" .. file_name
	if vim.fn.filereadable(checkScript) == 1 then
		return checkScript
	end
	return ""
end

local function get_config()
	local metals = require("metals")
	local scfg = require("modules2.lsp.server_config")
	local metals_config = metals.bare_config()
	metals_config.init_options.statusBarProvider = "on"
	metals_config.settings = {
		sbtScript = check_script_file("sbt"),
		millScript = check_script_file("millw"),
		-- serverVersion = "1.3.3",
		-- bloopVersion = "1.6.0",
		showImplicitArguments = true,
		showInferredType = true,
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}
	metals_config.handlers["metals/status"] = status.handler
	metals_config.on_attach = function(client, bufnr)
		scfg.on_attach(client, bufnr)
		scfg.enable_codelens(client)
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
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt" },
		group = utils.augroup("nvim-metals"),
		callback = function()
			if not global_config then
				global_config = get_config()
			end
			local buf_path = vim.fn.expand("%:p")
			if not string.find(buf_path, "stargazer") then
				start_metals(global_config)
			end
		end,
	})
end

return M
