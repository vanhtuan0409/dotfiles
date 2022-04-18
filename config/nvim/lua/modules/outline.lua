vim.g.symbols_outline = {
  highlight_hovered_item = false,
  auto_preview = false,
  width = 30,
  keymaps = {
    close = "q",
  }
}
vim.keymap.set("n", "<leader>o", ":SymbolsOutline<cr>")
