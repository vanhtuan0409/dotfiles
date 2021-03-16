local mappings = {}

-- Global mappings on completion
function mappings.setup_completion()
  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

  vim.api.nvim_set_keymap("i", "<C-Space>", [[compe#complete()]], {expr = true, silent = true})
  vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm('<CR>')]], {expr = true, silent = true})
  vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close('<C-e>')]], {expr = true, silent = true})
end

-- Mapping on attach
function mappings.setup_on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- mappings
  buf_set_keymap('n', 'K', [[:Lspsaga hover_doc<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', 'gh', [[:Lspsaga lsp_finder<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>rn', [[:Lspsaga rename<CR>]], { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>ga', [[:Lspsaga code_action<CR>]], { noremap=true, silent=true })

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap=true, silent=true })
end

return mappings
