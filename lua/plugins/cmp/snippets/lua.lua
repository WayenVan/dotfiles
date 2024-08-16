local type = "lua"

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local snippets = {
  {
    s("var", {
      t("local "),
      i(1),
      t(" = "),
      i(2),
      t(""),
    }),
  },
}

for i, snp in pairs(snippets) do
  ls.add_snippets(type, snp)
end
