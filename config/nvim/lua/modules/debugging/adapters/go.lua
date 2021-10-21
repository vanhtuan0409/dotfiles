local dap = require'dap'
local installer = require'installer'

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local host = config.host or "127.0.0.1"
  local port = config.port or 38697
  local addr = string.format("%s:%d", host, port)
  local dlv_bin = config.dlvToolPath or installer.bin("dlv")
  local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", addr},
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn(dlv_bin, opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      callback({type = "server", host = host, port = port})
    end,
    100)
end

dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug (current dir)';
    request = 'launch';
    showLog = false;
    program = '${relativeFileDirname}';
    cwd = '${workspaceFolder}';
  },
}
