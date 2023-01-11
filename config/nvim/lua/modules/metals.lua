local metals = require("metals")
local attach = require("modules.lsp.on_attach")

local function start_metals()
	vim.opt.shortmess:remove("F")
	require("telescope").load_extension("metals")
	vim.env.JAVA_HOME = "/usr/lib/jvm/java-19-graalvm"

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
		serverVersion = "0.11.10",
		bloopVersion = "1.5.6",
		showImplicitArguments = true,
		showInferredType = true,
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
