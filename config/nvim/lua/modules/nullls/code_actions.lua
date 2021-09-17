local M = {}
local u = require("null-ls.utils")
local loop = require("null-ls.loop")
local methods = require("null-ls.methods")

M.gostructhelper = {
  name = "gostructhelper",
  method = methods.internal.CODE_ACTION,
  filetypes = {"go"},
  generator = {
    async = true,
    fn = function(params, done)
      local bufnr = params.bufnr
      local linenr = vim.fn.line(".")
      local line = vim.api.nvim_buf_get_lines(bufnr, linenr-1, linenr, false)[1]
      local typ = line:match('^type (.*) struct')
      if not typ then
        done()
        return
      end

      local command = "gostructhelper"
      assert(
        vim.fn.executable(command) > 0,
        string.format("command %s is not executable (make sure it's installed and on your $PATH)", command)
      )

      local handler = function(error_output, output)
        u.debug_log("error output: " .. (error_output or "nil"))
        u.debug_log("output: " .. (output or "nil"))

        if not output then
          return
        end

        -- patch params method
        params.lsp_method = methods.lsp.FORMATTING
        require("null-ls.formatting").apply_edits({
          {
            row = 1,
            col = 1,
            end_row = vim.tbl_count(params.content) +  1,
            end_col = 1,
            text = output,
          },
        }, params)
      end
      local invoke_cli = function(args)
        local content = table.concat(params.content, "\n")
        local client = vim.lsp.get_client_by_id(params.client_id)
        local opts = {
          cwd = client and client.config.root_dir or vim.fn.getcwd(),
          input = content,
          handler = handler,
        }

        u.debug_log("spawning command " .. command .. " with args:")
        u.debug_log(args)
        loop.spawn(command, args, opts)
      end

      done({
        {
          title = "Generate constructor",
          action = function()
            invoke_cli({"-stdin", "-file", params.bufname, "-type", typ, "-no-getter"})
          end
        },
        {
          title = "Generate getter",
          action = function()
            invoke_cli({"-stdin", "-file", params.bufname, "-type", typ, "-no-constructor"})
          end
        },
        {
          title = "Generate constructor and getter",
          action = function()
            invoke_cli({"-stdin", "-file", params.bufname, "-type", typ})
          end
        },
      })
    end,
  }
}

return M
