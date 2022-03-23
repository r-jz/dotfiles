local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local isn = ls.indent_snippet_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  -- Snippets aren't automatically removed if their text is deleted.
  -- `delete_check_events` determines on which events (:h events) a check for
  -- deleted snippets is performed.
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment" } },
      },
    },
  },
})

ls.snippets = {
  all = {},
  python = {
    s("from", fmt([[from {} import {}]], { i(1, "package"), i(0, "module") })),
    s(
      { trig = "if(main)", name = "if name is main" },
      fmt(
        [[
      if __name__ == "__main__":
          {}
    ]],
        { i(0, "pass") }
      ),
      {
        condition = conds.line_begin,
      }
    ),
    s(
      { trig = "for", name = "for loop" },
      fmt(
        [[
    for {} in {}:
        {}
    ]],
        { i(1, "value"), i(2, "iterable"), i(0, "pass") }
      )
    ),
    s(
      { trig = "if", name = "if" },
      fmt(
        [[
    if {}:
      {}
    ]],
        { i(1, "cond"), i(0, "pass") }
      )
    ),
    s(
      { trig = "try/except", name = "try except" },
      fmt(
        [[
    try:
        {}
    except {} as {}:
        {}
    ]],
        { i(1), i(2, "Exception"), i(3, "error"), i(0, "pass") }
      )
    ),
    s(
      "def",
      fmt(
        [[
    def {}({}):
        {}
    ]],
        { i(1), i(2), i(0, "pass") }
      )
    ),
    s(
      { trig = "class", name = "new function" },
      fmt(
        [[
    class {}:
        {} 
    ]],
        { i(1), i(0, "pass") }
      )
    ),
  },
}
