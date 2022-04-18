local gitsigns = require('gitsigns')
gitsigns.setup {
  sign_priority = 5,
  keymaps = {},
}

vim.api.nvim_create_user_command("GitBlame", function(params)
  gitsigns.blame_line({ full = false })
end, { bang = true })
