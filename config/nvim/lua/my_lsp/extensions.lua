-- Ref: https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/hover.lua#L28
-- Avoid overlapping popup
function _G.custom_show_line_diagnostics(...)
  if not require'lspsaga.hover'.has_saga_hover() then
    require'lspsaga.diagnostic'.show_line_diagnostics(...)
  end
end

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
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

function _G.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

