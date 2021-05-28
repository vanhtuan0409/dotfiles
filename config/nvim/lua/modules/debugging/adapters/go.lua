local dap = require'dap'
local installer = require'installer'

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = { installer.bin("vscode_go") };
}

dap.configurations.go = {
  {
    type = 'go';
    name = 'Default debug';
    request = 'launch';
    showLog = false;
    program = '${workspaceFolder}/main.go';
    dlvToolPath = vim.fn.exepath('dlv');
  },
}
