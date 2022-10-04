local luasnip = require("luasnip")

-- some shorthands...
--local s = ls.snippet
--local sn = ls.snippet_node
--local t = ls.text_node
--local i = ls.insert_node
--local f = ls.function_node
--local c = ls.choice_node
--local d = ls.dynamic_node
--local r = ls.restore_node
--local isn = ls.indent_snippet_node
--local l = require("luasnip.extras").lambda
--local rep = require("luasnip.extras").rep
--local p = require("luasnip.extras").partial
--local m = require("luasnip.extras").match
--local n = require("luasnip.extras").nonempty
--local dl = require("luasnip.extras").dynamic_lambda
--local fmt = require("luasnip.extras.fmt").fmt
--local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local loaders = require("luasnip.loaders.from_lua")
--local conds = require("luasnip.extras.expand_conditions")

luasnip.config.set_config({
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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.snippet_expand_or_jump = function()
  if luasnip.expand_or_jumpable then
    return t("<Plug>luasnip-expand-or-jump")
  end
  return ""
end

_G.snippet_backword = function()
  if luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  end
  return ""
end

vim.keymap.set("i", "<C-k>", "v:lua.snippet_expand_or_jump()", { expr = true })
vim.keymap.set("s", "<C-k>", "v:lua.snippet_expand_or_jump()", { expr = true })
vim.keymap.set("i", "<C-j>", "v:lua.snippet_backword()", { expr = true })
vim.keymap.set("s", "<C-j>", "v:lua.snippet_backword()", { expr = true })
vim.keymap.set("i", "<C-l>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("s", "<C-l>", "<Plug>luasnip-next-choice", {})

loaders.load()
