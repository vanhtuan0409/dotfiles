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
    program = '${relativeFileDirname}';
    cwd = '${workspaceFolder}';
    dlvToolPath = installer.bin("dlv");
  },
}
