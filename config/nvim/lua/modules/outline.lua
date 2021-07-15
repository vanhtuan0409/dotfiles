vim.g.symbols_outline = {
  highlight_hovered_item = false,
  auto_preview = false,
  keymaps = {
    close = "q",
  }
}
require"vimp".nnoremap({'override'}, "<leader>o", ":SymbolsOutline<cr>")
