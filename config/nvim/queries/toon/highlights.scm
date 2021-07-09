((type) @type.builtin
 (#any-of? @type.builtin
           "bool"
           "number"
           "string"
           "void"))
(ident) @property

(argument_list (ident) @parameter)
(call_expression func_name: (ident) @function)

(string_lit) @string
(escape_sequence) @string.escape
(number_lit) @float
(bool_lit) @boolean

[
  "let"
] @keyword

[
  "+"
  "-"
  "*"
  "/"
  "="
] @operator


";" @punctuation.delimiter
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

(comment) @comment
