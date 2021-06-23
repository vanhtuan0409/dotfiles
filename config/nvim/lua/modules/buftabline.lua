local M = {}
local option = vim.api.nvim_buf_get_option

function M.bufonly()
    local del_non_modifiable = vim.g.bufonly_delete_non_modifiable or false
    local cur = vim.api.nvim_get_current_buf()
    for _, n in ipairs(vim.api.nvim_list_bufs()) do
        if n ~= cur and (option(n, "modifiable") or del_non_modifiable) then
            vim.api.nvim_buf_delete(n, {})
        end
    end
end

function M.setup()
  vim.cmd([[command! Bonly :lua require'modules/buftabline'.bufonly()]])

  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<C-d>', ":bd<CR>", opts)
  vim.api.nvim_set_keymap('n', '<C-w>', ":bufdo :bd<CR>", opts)
  vim.api.nvim_set_keymap('n', '<Tab>', ":BufNext<CR>", opts)
  vim.api.nvim_set_keymap('n', '<S-Tab>', ":BufPrev<CR>", opts)
end

function M.config()
  require("buftabline").setup{
    go_to_maps = false,
    show_no_name_buffers = false,
  }
end

return M
