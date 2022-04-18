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

  require("utils").keymap_set_multi("n", {
    ["<C-d>"]   = ":bd<CR>",
    ["<C-w>"]   = ":bufdo :bd<CR>",
    ["<Tab>"]   = ":BufNext<CR>",
    ["<S-Tab>"] = ":BufPrex<CR>",
  })
end

function M.config()
  require("buftabline").setup{
    go_to_maps = false,
  }
end

return M
