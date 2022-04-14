---@diagnostic disable: undefined-global
-- local s = require('luasnippet.snipet')

return {
  s(
    "ifm",
    fmt(
      [[if __name__ == "__main__":
    {pass}]],
      { pass = i(0, "pass") }
    )
  ),
  s("from", { t("from "), i(1, "library"), t(" import "), i(0, "module") }),
  s(
    "property",
    fmt(
      [[@property
def {}(self):
    return self._{}]],
      { i(1, "property"), rep(1) }
    )
  ),
}
