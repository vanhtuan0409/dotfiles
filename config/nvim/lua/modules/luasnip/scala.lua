local ls = require("luasnip")
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dchoice = ls.dynamic_node

ls.add_snippets("scala", {
  snip("anduin-trademark", {
    text("// Copyright (C) 2014-2022 Anduin Transactions Inc.")
  })
})
