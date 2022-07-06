require("indent_blankline").setup {
  char = '│',
  use_treesitter = true,
  filetype_exclude = {"packer"},
  show_current_context = true,
  context_highlight_list = {"WarningMsg"},
  use_treesitter_scope = false,
}
