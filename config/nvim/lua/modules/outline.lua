vim.g.symbols_outline = {
  highlight_hovered_item = false,
  auto_preview = false,
}
vim.api.nvim_set_keymap("n", "<leader>o", ":SymbolsOutline<cr>", { silent=true, noremap = true})
