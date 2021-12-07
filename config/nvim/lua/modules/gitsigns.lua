require('gitsigns').setup {
  sign_priority = 5,
  keymaps = {},
}

vim.cmd [[command! GitBlame lua require"gitsigns".blame_line{full=false}]]
