local neorg_leader = "<Leader>r"
local neorg_callbacks = require('neorg.callbacks')

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  keybinds.map_event_to_mode("norg", {
    n = {
      { "gtd", "core.norg.qol.todo_items.todo.task_done" },
      { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
      { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
    },
  }, { silent = true, noremap = true })

  keybinds.map_event_to_mode("gtd-displays", {
    n = {
      { "<CR>", "core.gtd.ui.goto_task" },

      -- Keys for closing the current display
      { "q", "core.gtd.ui.close" },
      { "<Esc>", "core.gtd.ui.close" },

      { "e", "core.gtd.ui.edit_task" },
      { "<Tab>", "core.gtd.ui.details" },
    },
  }, { silent = true, noremap = true, nowait = true })
end)
