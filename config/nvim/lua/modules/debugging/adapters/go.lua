local dap = require'dap'

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = { vim.fn.stdpath("data") .. '/dapAdapters/vscode-go/dist/debugAdapter.js' };
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
