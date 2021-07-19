local vimp = require('vimp')
local luasnip = require("utils").prequire("luasnip")

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    vsnip = false;
    luasnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = false;
    tags = false;
    snippets_nvim = true;
    treesitter = false;
    omni = false;
  };
}

-- Use Tab and S-Tab to cycle
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function _G.tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t "<Plug>luasnip-expand-or-jump"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

function _G.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif luasnip and luasnip.jumpable(-1) then
    return t "<Plug>luasnip-jump-prev"
  else
    return t "<S-Tab>"
  end
end

vimp.imap({'expr', 'silent'}, "<C-Space>", [[compe#complete()]])
vimp.imap({'expr', 'silent'}, "<C-e>", [[compe#close('<C-e>')]])
vimp.imap({'expr', 'silent'}, "<Tab>", "v:lua.tab_complete()")
vimp.smap({'expr', 'silent'}, "<Tab>", "v:lua.tab_complete()")
vimp.imap({'expr', 'silent'}, "<S-Tab>", "v:lua.s_tab_complete()")
vimp.smap({'expr', 'silent'}, "<S-Tab>", "v:lua.s_tab_complete()")
