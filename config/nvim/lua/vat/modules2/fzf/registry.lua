local registry = {
	autocmds = function(FzfLua)
		FzfLua.autocmds()
	end,
	highlights = function(FzfLua)
		FzfLua.highlights()
	end,
	commands = function(FzfLua)
		FzfLua.commands()
	end,
	keymaps = function(FzfLua)
		FzfLua.keymaps()
	end,
}

local M = {}

function M.add(name, fn)
	registry[name] = fn
end

function M.entries()
	return registry
end

return M
