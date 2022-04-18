local M = {}
local option = vim.api.nvim_buf_get_option

local bufonly = function()
    local del_non_modifiable = vim.g.bufonly_delete_non_modifiable or false
    local cur = vim.api.nvim_get_current_buf()
    for _, n in ipairs(vim.api.nvim_list_bufs()) do
        if n ~= cur and (option(n, "modifiable") or del_non_modifiable) then
            vim.api.nvim_buf_delete(n, {})
        end
    end
end

function M.setup()
  vim.api.nvim_create_user_command("Bonly", function(params)
    bufonly()
  end, { bang = true })

  vim.keymap.set('n', '<C-d>', ":bd<CR>")
  vim.keymap.set('n', '<C-w>', ":bufdo :bd<CR>")
  vim.keymap.set('n', '<Tab>', ":BufNext<CR>")
  vim.keymap.set('n', '<S-Tab>', ":BufPrev<CR>")
end

function M.config()
  require("buftabline").setup{
    go_to_maps = false,
  }
end

return M
