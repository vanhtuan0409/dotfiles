local M = {}
local option = vim.api.nvim_buf_get_option
local vimp = require("vimp")

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

  vimp.nnoremap('<C-d>', ":bd<CR>")
  vimp.nnoremap('<C-w>', ":bufdo :bd<CR>")
  vimp.nnoremap('<Tab>', ":BufNext<CR>")
  vimp.nnoremap('<S-Tab>', ":BufPrev<CR>")
end

function M.config()
  require("buftabline").setup{
    go_to_maps = false,
    show_no_name_buffers = false,
  }
end

return M
