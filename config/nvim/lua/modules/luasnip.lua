local ls = require("luasnip")

ls.config.set_config({
  history = false,
  delete_check_events = "TextChanged,InsertLeave",
})
